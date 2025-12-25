---
title: Мониторинг состояния кластера {{ SPRK }}
description: Вы можете отслеживать состояние кластера {{ SPRK }} с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monitoring-full-name }} для автоматического мониторинга состояния кластера.
---

# Мониторинг состояния кластера {{ SPRK }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Графики обновляются раз в 15 секунд.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ SPRK }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице отображаются графики:

  * В блоке **Cluster Resource Usage**:

    * **Total Allocated Nodes** — количество используемых хостов кластера.
    * **Total Running Containers & Total Running Jobs** — количество запущенных заданий и контейнеров.

      * **Spark Containers** — количество запущенных контейнеров.
      * **Spark Jobs** — количество запущенных заданий.

    * **Pending Containers** — количество контейнеров, ожидающих запуска.
    * **CPU Resources** — доступность процессорных ядер.
  
      * **Allocated CPU** — количество используемых CPU.
      * **Allocatable CPU** — количество доступных для контейнеров CPU.
      * **Capacity CPU** — общее количество CPU в кластере. Часть CPU может быть зарезервирована под системные нужды.

    * **Available CPU** — количество доступных CPU в кластере.
    * **CPU Usage/Limits** — расход CPU контейнерами.

      * **Additional containers CPU limited** — предел использования CPU для служебных контейнеров.
      * **Additional containers CPU usage** — количество CPU, используемое служебными контейнерами.
      * **Spark containers CPU usage** — предел использования CPU для контейнеров Spark-приложений.
      * **Spark containers CPU limited** — количество CPU, используемое контейнерами Spark-приложений.

    * **Memory Resources** — доступность памяти.

      * **Capacity Memory** — общий объем памяти хостов. Часть памяти может быть зарезервирована под системные нужды.
      * **Allocatable Memory** — объем доступной для контейнеров памяти хостов.
      * **Allocated Memory** – используемый объем памяти хостов.

    * **Available Memory** — объем доступной памяти в кластере.
    * **Memory Usage/Limits** – расход памяти контейнерами.

      * **Additional containers Memory limited** — предел памяти для служебных контейнеров.
      * **Additional containers Memory usage** — память, используемая служебными контейнерами.
      * **Spark containers Memory limited** — предел памяти для контейнеров Spark-приложений.
      * **Spark containers Memory usage** — память, используемая контейнерами Spark-приложений.

  * В блоке **Driver Pool**:

    * **Driver Pool: Allocated Nodes** — количество хостов драйверов {{ SPRK }}.
    * **Driver Pool: Running Containers** — количество работающих контейнеров в пуле драйверов.
    * **Spark Drivers: Running Containers By Nodes** — количество работающих контейнеров по хостам драйверов {{ SPRK }}.
    * **Spark Drivers: CPU Limits By Nodes** — лимит CPU по хостам драйверов {{ SPRK }}.
    * **Spark Drivers: Used CPU By Nodes** — используемые CPU по хостам драйверов {{ SPRK }}.
    * **Driver Pool: Available CPU By Nodes** — доступные CPU по хостам драйверов {{ SPRK }}.
    * **Spark Drivers: Memory Limits By Nodes** — лимит памяти по хостам драйверов {{ SPRK }}.
    * **Spark Drivers: Used Memory By Nodes** — используемая память по хостам драйверов {{ SPRK }}.
    * **Driver Pool: Available Memory By Nodes** — доступная память по хостам драйверов {{ SPRK }}.

  * В блоке **Executor Pool**:

    * **Executor Pool: Allocated Nodes** — количество хостов исполнителей {{ SPRK }}.
    * **Executor Pool: Running Containers** — количество работающих контейнеров в пуле исполнителей {{ SPRK }}.
    * **Spark Executors: Running Containers By Node** — количество работающих контейнеров по хостам исполнителей {{ SPRK }}.
    * **Spark Executors: CPU Limits By Nodes** — лимит CPU по хостам исполнителей {{ SPRK }}.
    * **Spark Executors: Used CPU By Nodes** — используемые CPU по хостам исполнителей {{ SPRK }}.
    * **Executor Pool: Available CPU By Nodes** — доступные CPU по хостам исполнителей {{ SPRK }}.
    * **Spark Executors: Memory Limits By Nodes** — лимит памяти по хостам исполнителей {{ SPRK }}.
    * **Spark Executors: Used Memory By Nodes** — используемая память по хостам исполнителей {{ SPRK }}.
    * **Executor Pool: Available Memory By Nodes** — доступная память по хостам исполнителей {{ SPRK }}.

  * В блоке **Spark Jobs**:

    * **Running Executors By Jobs** — количество хостов исполнителей {{ SPRK }} по выполняемым заданиям.
    * **Spark Application: Running Stages** — количество выполняемых этапов по заданиям.
    * **Spark Application: Active Tasks** — количество выполняемых задач по заданиям.
    * **Spark CPU Limits By Jobs** — лимит CPU по заданиям.
    * **Spark Used CPU By Jobs** — используемые CPU по заданиям.
    * **Spark Application: Completed Stages** — количество завершенных этапов по заданиям.
    * **Spark Memory Limits By Jobs** — лимит памяти по заданиям.
    * **Spark Used Memory By Jobs** — используемая память по заданиям.
    * **Spark Application: Completed Tasks** — количество завершенных задач по заданиям.
    * **Spark Application: Failed Stages** — количество этапов выполнения заданий, завершившихся с ошибками, по заданиям.
    * **Spark Application: Waiting Stages** — количество этапов выполнения заданий в ожидании, по заданиям.
    * **Spark Application: Failed Tasks** — количество задач, завершенных с ошибками, по заданиям.

{% endlist %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ msp-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-spark-ref.md).

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
