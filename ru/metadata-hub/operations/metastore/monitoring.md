---
title: Мониторинг состояния кластера {{ metastore-name }}
description: Из статьи вы узнаете, как осуществлять мониторинг состояния кластера {{ metastore-name }}.
---

# Мониторинг состояния кластера {{ metastore-name }}

{% include [monitoring-introduction](../../../_includes/mdb/monitoring-introduction.md) %}

Графики обновляются раз в 15 секунд.

{% include [note-monitoring-auto-units](../../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ metastore-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

  1. {% include [open-in-yandex-monitoring](../../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице отображаются графики:

  * В блоке **API**:

    * **API Calls (rps)** — методы с наибольшим количеством выполненных запросов для каждого инстанса кластера. Список методов обновляется динамически. График может отображать до десяти методов.
    * **API Latency (p95)** — 95-й процентиль общего времени выполнения запросов с разбивкой по инстансам.
    * **Active Calls** — количество находящихся в обработке запросов.
    * **API Latency by method (p95)** — методы с наибольшим 95-м процентилем времени выполнения запросов для каждого инстанса кластера. Список методов обновляется динамически. График может отображать до десяти методов.

  * В блоке **Transactions & Errors**:

    * **Open Transactions / Connections** — количество активных транзакций и подключений:
      * **Open Transactions** — количество активных [ACID](https://ru.wikipedia.org/wiki/ACID)-транзакций.
      * **Open Connections** — количество активных подключений к кластеру {{ metastore-name }} по протоколу Thrift.
    * **Compaction Cycle Duration** — продолжительность цикла сжатия.
    * **DirectSQL Errors** — количество ошибок при выполнении DirectSQL-запросов, после которых {{ metastore-name }} перешел к выполнению запросов через JDO.

  * В блоке **Connection Pools** (только для {{ metastore-name }} версии `4.2`):

    * **Connection States** — количество JDBC-подключений:
      * **Active Connections** — активные подключения.
      * **Idle Connections** — простаивающие подключения.
      * **Pending Connections** — количество запросов, ожидающих выделения подключения.
      * **Total Connections** — общее количество подключений.

    * **Pool Usage (p95)** — 95-й процентиль времени, в течение которого приложение удерживает установленное подключение.
    * **Connection Creation (p95)** — 95-й процентиль продолжительности создания подключения.
    * **Pool Connection Timeouts (rps)** — количество запросов в секунду, завершившихся таймаутом из-за отсутствия доступных подключений.

  * В блоке **DB Objects**:

    * **Object Counts** — количество баз данных, таблиц и партиций в хранилище кластера {{ metastore-name }}.
    * **Object Operations (rps)** — количество операций создания и удаления баз данных, таблиц и партиций в секунду.

  * В блоке **Resources**:

    * **Instances** — количество инстансов в кластере.
    * **CPU Usage** — использование процессорного времени каждым инстансом в процентах от общего количества доступного времени.
    * **Memory Usage** — использование оперативной памяти каждым инстансом в процентах от общего объема доступной памяти.

  * В блоке **JVM Memory**:

    * **JVM Heap** — максимальный объем heap-памяти JVM и ее использование каждым инстансом.
    * **JVM Memory Pools** — пулы с наибольшим объемом использованной каждым инстансом памяти JVM. График отображает до шести пулов. Список пулов формируется динамически.

  * В блоке **JVM Runtime**:

    * **GC Rate** — скорость работы сборщиков мусора старого (G1_Old_Generation) и нового (G1_Young_Generation) поколения на каждом инстансе.
    * **JVM Pauses** — количество остановок всех потоков JVM, длительность которых превысила заданные пороги для информирования и предупреждения.

{% endlist %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите]({{ link-monitoring }}) в сервис ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **Managed Service For Hive Metastore — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов в [документации {{ monitoring-full-name }}](../../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                               | Обозначение                | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`                 |
|---------------------------------------|:--------------------------:|:-------------------------:|:-------------------------:|
| Использование процессорного времени                   | `cpu_usage` | 90%                      | 80%                       |
| Использование оперативной памяти     | `memory_usage`        | 90% | 80% |
| 95-й процентиль общего времени выполнения запросов     | `metastore_api_calls_duration_seconds`    | 10 секунд                         | 3 секунды                    |
| Количество запросов, ожидающих выделения подключения      | `metastore_pool_pending_connections`          | —  | Больше нуля в течение пяти минут  |
| Количество запросов, завершившихся таймаутом из-за отсутствия доступных подключений | `metastore_pool_connection_timeouts_total` | Больше нуля | — |
| Количество ошибок при выполнении DirectSQL-запросов, после которых {{ metastore-name }} перешел к выполнению запросов через JDO | `metastore_directsql_errors_total` | — | Больше нуля |

Полный список поддерживаемых метрик в [документации {{ monitoring-name }}](../../../monitoring/metrics-ref/managed-metastore-ref.md).

## Состояние и статус кластера {#cluster-health-and-status}

_{{ ui-key.yacloud.mdb.cluster.overview.label_health }}_ кластера указывает на его исправность, а _{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ показывает, запущен кластер, остановлен или находится в промежуточном состоянии.

Для просмотра состояния и статуса кластера:

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
1. В строке нужного кластера наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

### Состояния кластера {#cluster-health}

#|
|| Состояние | Описание | Предлагаемые действия ||
|| **ALIVE** | Кластер работает в штатном режиме. | Действий не требуется. ||
|| **DEGRADED** | Кластер работает не на полную мощность. |
[Составьте обращение в службу поддержки]({{ link-console-support }}), указав:
* Идентификатор кластера.
* Идентификаторы последних операций, которые на нем выполнялись.
* Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEGRADED`. ||
|| **DEAD** | Кластер неработоспособен. |
[Составьте обращение в службу поддержки]({{ link-console-support }}), указав:
* Идентификатор кластера.
* Идентификаторы последних операций, которые на нем выполнялись.
* Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`. ||
|| **UNKNOWN** | Состояние кластера неизвестно. |
[Составьте обращение в службу поддержки]({{ link-console-support }}), указав:
* Идентификатор кластера.
* Идентификаторы последних операций, которые на нем выполнялись.
* Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`. ||
|#

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../../_includes/mdb/monitoring-cluster-status.md) %}
