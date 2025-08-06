---
title: Мониторинг состояния кластера {{ mtr-name }}
description: Из статьи вы узнаете, как осуществлять мониторинг состояния кластера {{ mtr-name }}.
---

# Мониторинг состояния кластера {{ mtr-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Графики обновляются раз в 15 секунд.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mtr-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице отображаются графики:

  * В блоке **Cluster**:

    * **Total cluster nodes** — количество хостов кластера.
    * **Total Available Processors** — количество доступных CPU.
    * **Cluster distributed memory (cluster memory pool)** — объем распределенной памяти кластера.
        
      * **Total Distributed Bytes** — общий объем памяти (в гигабайтах).
      * **Free Distributed Bytes** — объем свободной памяти (в гигабайтах).

  * В блоке **Queries**:

    * **Queries (executing)** — запросы (выполняющиеся).

      * **Running** — выполняется хотя бы одна часть плана запроса.
      * **Queued** — запрос принят и ожидает выполнения.
      * **Progressing** — запрос выполняется, и его ничто не блокирует.
      * **Finishing** — выполнение запроса завершается.

    * **Queries (by status)** — запросы (по статусу).

      * **Submitted** — принятые запросы.
      * **Started** — выполняемые запросы.
      * **Failed** — запросы, выполнение которых завершилось ошибкой.
      * **Completed** — завершенные запросы, в том числе те, выполнение которых завершилось ошибкой.
      * **Canceled** — запросы, выполнение которых отменил пользователь.
      * **Abandoned** — запросы, результаты выполнения которых остались невостребованными.

    * **Errors** — ошибки и их типы. Указано число ошибок в секунду.

      * **UserError** — ошибки на стороне пользователя.
      * **Internal** — ошибки на стороне сервера.
      * **InsufficientResources** — ошибки, вызванные недостатком ресурсов.
      * **External** — внешние ошибки.

  * В блоке **Execution**:

      * **Timings, p95 (One minute)** — 95-й процентиль времени выполнения запросов с окном в одну минуту.

{% endlist %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ mtr-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-kafka-ref.md).