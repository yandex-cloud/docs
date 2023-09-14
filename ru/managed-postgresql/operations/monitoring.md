---
title: "Мониторинг состояния кластера PostgreSQL и хостов"
description: "Вы можете отслеживать состояние кластера {{ mpg-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monitoring-full-name }} для автоматического мониторинга состояния кластера."
---

# Мониторинг состояния {{ PG }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mpg-name }}:

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На странице появятся следующие графики:

* **Age of oldest transaction/statement** — время хранения наиболее ранней транзакции и выполнения операторов.
* **Average transaction/statement time** — среднее время обработки транзакций и выполнения операторов.
* **CPU usage** — загрузка процессорных ядер.
* **Disk read/write bytes** — скорость дисковых операций чтения и записи (байт/с).
* **Disk read/write IOPS** — интенсивность дисковых операций чтения и записи (операций/с).
* **Disk usage by DB** — использование дискового пространства по базам данных (в байтах).
* **Disk usage on primary** — использование дискового пространства на хосте-мастере (в байтах).
* **Inode usage by host** — использованное количество inodes по хостам.
* **Inode usage on primary** — использованное количество inodes на хосте-мастере.
* **Is Primary, [boolean]** — показывает, какой хост является мастером и как долго.
* **Free space** — свободное дисковое пространство для каждого хоста (в байтах).
* **Log errors** — количество логированных ошибок в секунду.
* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Network received/sent bytes** — скорость обмена данными по сети (байт/с).
* **Packets received/sent** — интенсивность обмена данными по сети (пакетов/с).
* **Pooler is alive, [boolean]** — работоспособность пулера, для каждого хоста в каждой из ролей: мастера и реплики.
* **PostgreSQL Alive, [boolean]** — работоспособность PostgreSQL, для каждого хоста в каждой из ролей: мастера и реплики.
* **Replication lag** — время задержки репликации.
* **Session CPU usage cores** — количество занятых процессорных ядер по видам сессий.
* **Sessions per wait event** — количество ожидающих сессий по видам ожидания.
* **Sessions read bytes** — объем прочитанных данных по видам сессий (в байтах).
* **Sessions write bytes** — объем записанных данных по видам сессий (в байтах).
* **Statement quantiles** — время выполнения операторов по процентилям.
* **TCP connections** — количество TCP-подключений в секунду.
* **Total pooler connections** — количество подключений пулера: клиентских и серверных.
* **Total size of temporary files** — суммарный размер временных файлов (в байтах).
* **Total size of WAL files** — суммарный размер [файлов WAL](../concepts/backup.md) (в байтах).
* **Transaction quantiles** — время обработки транзакций по процентилям.
* **Transactions/statements per second** — количество транзакций и операторов в секунду.

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mpg-name }}:

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Выберите нужный хост из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
* **Disk IOPS** — интенсивность дисковых операций (операций/с).
* **Disk read/write bytes** — скорость дисковых операций (байт/с).
* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Network Bytes** — скорость обмена данными по сети (байт/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

На графиках **Disk read/write bytes** и **Disk IOPS** характеристика **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
    1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. В блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}** выберите:
        * **{{ mpg-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mpg-name }} — Host Overview** для настройки алертов хостов.
    1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud.common.continue }}**. Подробнее о языке запросов [см. документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
    1. Нажмите кнопку **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                               | Обозначение                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Задержка репликации                   | `postgres-replication_lag` | `60`                      | `5`                       |
| Количество работоспособных хостов     | `postgres-is_alive`        | `<количество хостов> - 2` | `<количество хостов> - 1` |
| Среднее время выполнения запросов     | `pooler-avg_query_time`    | —                         | `2000`                    |
| Размер использованного хранилища      | `disk.used_bytes`          | 90% от размера хранилища  | 80% от размера хранилища  |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-postgresql).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

