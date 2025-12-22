---
title: Мониторинг состояния кластера PostgreSQL и хостов
description: Вы можете отслеживать состояние кластера {{ mpg-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monitoring-full-name }} для автоматического мониторинга состояния кластера.
---

# Мониторинг состояния кластера {{ PG }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}


Чтобы обнаружить возможные проблемы в кластере, [используйте другие инструменты](../tutorials/performance-problems.md) для анализа состояния кластера вместе с мониторингом.


## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mpg-name }}:

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На странице появятся следующие графики:

* В блоке **Cluster**:

   * **PostgreSQL Alive, [boolean]** — работоспособность PostgreSQL, для каждого хоста в каждой из ролей: мастера и реплики.
   * **Is Primary, [boolean]** — показывает, какой хост является мастером и как долго.
   * **Replication lag** — время задержки репликации.

       {% note warning %}

       Время задержки репликации рассчитывается с точностью до одной секунды. Если задержка меньше одной секунды, ее невозможно отследить с помощью этой метрики.

       {% endnote %}
    
   * **Average CPU usage** — среднее время обработки транзакций и выполнения операторов.
   * **Maximum CPU usage** — пиковая загрузка процессорных ядер.
   * **Maximum memory usage** — пиковое использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
   * **Log errors** — количество логированных ошибок в секунду.
   * **OOM Count** — наличие процессов Out-Of-Memory Killer. Они останавливают приложения, которые расходуют всю память на машине, и предотвращают аварийную остановку ОС.

* В блоке **Disk**:

   * **Disk usage on primary** — использование дискового пространства на хосте-мастере (в байтах).
   * **Disk read/write bytes** — скорость дисковых операций чтения и записи (байт/с).
   * **Disk read/write IOPS** — интенсивность дисковых операций чтения и записи (операций/с).
   * **Disk usage by DB** — использование дискового пространства по базам данных (в байтах).
   * **Inode usage on primary** — использованное количество inode на хосте-мастере.
   * **Inode usage by host** — использованное количество inode по хостам.
   * **Total size of temporary files** — суммарный размер временных файлов (в байтах).
   * **Total size of WAL files** — суммарный размер [файлов WAL](../concepts/backup.md) (в байтах).
   * **Free space** — свободное дисковое пространство для каждого хоста (в байтах).
   * **WAL rate in bytes** — скорость записи файлов WAL в байтах в секунду.

* В блоке **Transactions**:

   * **Transactions/statements per second** — количество транзакций и операторов в секунду.
   * **Average transaction/statement time** — среднее время обработки транзакций и выполнения операторов.
   * **Age of oldest transaction/statement** — возраст самой старой транзакции/запроса.
   * **Statement quantiles** — время выполнения операторов по процентилям.
   * **Transaction quantiles** — время обработки транзакций по процентилям.
   * **Used/Free Transaction IDs** — используемые/свободные идентификаторы транзакций
   * **Transaction IDs left** — остаток доступных идентификаторов транзакций.

* В блоке **Vacuum**:

   * **Vacuum processes** — количество процессов, выполняющих операцию вакуумирования.
   * **Scanning progress** — прогресс сканирования в процессе вакуумирования.
   * **Vacuuming progress** — прогресс выполнения операции вакуумирования.

* В блоке **Sessions**:

   * **Sessions read bytes per second** — объем прочитанных данных по видам сессий (в байтах).
   * **Sessions write bytes per second** — объем записанных данных по видам сессий (в байтах).
   * **Session CPU usage cores** — количество занятых процессорных ядер по видам сессий.
   * **Sessions per wait event** — количество ожидающих сессий по видам ожидания.

* В блоке **Connections**:

   * **Pooler is alive, [boolean]** — работоспособность менеджера подключений, для каждого хоста в каждой из ролей: мастера и реплики.
   * **Total pooler connections** — количество подключений в менеджере подключений: клиентских и серверных.
   * **TCP connections** — количество TCP-подключений в секунду.

* В блоке **Network**:

   * **Packets received/sent** — интенсивность обмена данными по сети (пакетов/с).
   * **Network received/sent bytes** — скорость обмена данными по сети (байт/с).


## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mpg-name }}:

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
1. Нажмите на строку нужного хоста в списке.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Disk usage** — использование дискового пространства (в байтах).
* **Disk usage by DB** — использование дискового пространства по базам данных (в байтах).
* **Disk read/write bytes** — скорость дисковых операций (байт/с).
* **Disk IOPS** — интенсивность дисковых операций (операций/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).
* **Network Bytes** — скорость обмена данными по сети (байт/с).

На графиках **Disk read/write bytes** и **Disk IOPS** характеристика **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. В блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}** выберите:
        * **{{ mpg-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mpg-name }} — Host Overview** для настройки алертов хостов.
    1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud.common.continue }}**. Подробнее о языке запросов [см. документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                               | Обозначение                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Задержка репликации                   | `postgres-replication_lag` | `60`                      | `5`                       |
| Количество работоспособных хостов     | `postgres-is_alive`        | `<количество_хостов> - 2` | `<количество_хостов> - 1` |
| Среднее время выполнения запросов     | `pooler-avg_query_time`    | —                         | `2000`                    |
| Размер использованного хранилища      | `disk.used_bytes`          | 90% от размера хранилища  | 80% от размера хранилища  |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-postgresql-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

