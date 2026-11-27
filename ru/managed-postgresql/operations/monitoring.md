---
title: Мониторинг состояния кластера PostgreSQL и хостов
description: Вы можете отслеживать состояние кластера {{ mpg-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monium-full-name }} для автоматического мониторинга состояния кластера.
alternate:
  - href: ru/managed-postgresql/operations/monitoring.md
    type: text/markdown
    title: Markdown version
---

# Мониторинг состояния кластера {{ PG }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}


Чтобы обнаружить возможные проблемы в кластере, [используйте другие инструменты](../tutorials/performance-problems.md) для анализа состояния кластера вместе с мониторингом.


## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mpg-name }}:

1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Нажмите на имя нужного кластера и выберите ![chevron-down](../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** → **{{ ui-key.yacloud.postgresql.cluster.switch_monitoring }}**.

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
   * **WAL rate in bytes per second** — скорость записи файлов WAL в байтах в секунду.

* В блоке **Transactions**:

   * **Transactions/statements per second** — количество транзакций и операторов в секунду.
   * **Average transaction/statement time** — среднее время обработки транзакций и выполнения операторов.
   * **Age of oldest transaction/statement** — возраст самой старой транзакции/запроса.
   * **Statement quantiles** — время выполнения операторов по процентилям.
   * **Transaction quantiles** — время обработки транзакций по процентилям.
   * **Used/Free Transaction IDs (%)** — используемые/свободные идентификаторы транзакций в процентах.
   * **Used/Free Transaction IDs** — используемые/свободные идентификаторы транзакций.

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

1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
1. Нажмите на строку нужного хоста в списке.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Disk usage** — использование дискового пространства (в байтах).
* **Disk usage by DB** — использование дискового пространства по базам данных (в байтах).
* **Disk IOPS** — интенсивность дисковых операций (операций/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).
* **Network Bytes** — скорость обмена данными по сети (байт/с).
* **Disk Metrics Details**:

   * **Disk used quota** — средний и максимальный процент использования квоты для дисковых операций.
   * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
   * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
   * **Disk read latency (percentiles)** — задержка чтения с диска по процентилям.
   * **Disk write latency (percentiles)** — задержка записи на диск по процентилям.
   * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
   * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
   * **Disk read bytes** — средняя и максимальная скорость чтения с диска (байт/с).
   * **Disk write bytes** — средняя и максимальная скорость записи на диск (байт/с).

На графике **Disk IOPS** характеристика **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.



## Мониторинг состояния балансировщика DB Proxy {#monitoring-dbproxy}

Если в вашем кластере {{ mpg-name }} включен [балансировщик DB Proxy](../concepts/load-balancer.md), вы можете просмотреть детальную информацию о его состоянии:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

1. Нажмите на имя нужного кластера и выберите вкладку **DB Proxy**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На странице появятся следующие графики:

* **Balancer is alive, [boolean]** — работоспособность балансировщика на каждом хосте кластера.
* **Balancer TCP connections by host** — количество TCP-подключений к балансировщику на каждом хосте кластера.
* **Balancer bytes received per second** — объем данных, проходящий через балансировщик за секунду.
* **Balancer CPU usage** — доля использования балансировщиком процессорных ядер на каждом хосте кластера.
* **Balancer memory usage** — лимит оперативной памяти и ее использование балансировщиком на каждом хосте кластера.




## Настройка алертов в {{ monium-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в который поступают метрики кластера.

      Метрики кластера передаются в проект {{ monium-name }} `folder__<идентификатор_каталога>`, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен этот кластер.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В открывшемся списке выберите:

      * **{{ mpg-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mpg-name }} — Host Overview** для настройки алертов хостов.
  1. В параметрах дашборда выберите нужный кластер и, при необходимости, хосты.
  1. На нужном графике нажмите ![rectangle-pulse](../../_assets/console-icons/rectangle-pulse.svg) **Перейти в Метрики**.
  1. На панели нужного запроса справа вверху нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Создать алерт по запросу** или **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
  1. Укажите название алерта. В блоке **Условия срабатывания** выберите запрос для проверки и задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`.
  1. Чтобы получать уведомления, добавьте [канал уведомлений](../../monium/operations/alert/create-channel.md).
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

#|
|| Метрика | Обозначение | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` ||
|| Задержка репликации | `postgres-replication_lag` | `60` | `5` ||
|| Количество работоспособных хостов | `postgres-is_alive` | `<количество_хостов> - 2` | `<количество_хостов> - 1` ||
|| Среднее время выполнения запросов | `pooler-avg_query_time` | — | `2000` ||
|| Размер использованного хранилища | `disk.used_bytes` | 90% от размера хранилища | 80% от размера хранилища ||
|#

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик вы найдете в [документации {{ monium-name }}](../../monium/metrics-ref/managed-postgresql-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

#### Восстановление кластера в состоянии DEAD {#restore-dead-cluster}

{% include [restore-dead-cluster](../../_includes/mdb/restore-dead-cluster.md) %}

1. [Восстановите кластер из резервной копии](cluster-backups.md#restore).
1. Обновите параметры подключения в приложениях и проверьте доступ к данным в новом кластере.
1. Проанализируйте нагрузку на кластер, чтобы выявить ресурсоемкие запросы и сессии. Для этого [проведите диагностику производительности](performance-diagnostics.md). Используйте рекомендации по [поиску проблем с производительностью](../tutorials/performance-problems.md) и [оптимизации запросов](../tutorials/profiling.md).

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

