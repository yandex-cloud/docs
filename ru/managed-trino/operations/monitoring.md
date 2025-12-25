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
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
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
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ mtr-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-trino-ref.md).

## Состояние и статус кластера {#cluster-health-and-status}

_{{ ui-key.yacloud.mdb.cluster.overview.label_health }}_ кластера указывает на его исправность, а _{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ показывает, запущен кластер, остановлен или находится в промежуточном состоянии.

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
1. В строке нужного кластера наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

### Состояния кластера {#cluster-health}

Состояние | Описание | Предлагаемые действия
:--- | :--- | :---
**ALIVE** | Кластер работает в штатном режиме. | Действий не требуется.
**DEGRADED** | Кластер работает не на полную мощность. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEGRADED`.</li></ul>
**DEAD** | Кластер неработоспособен. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`.</li></ul>
**UNKNOWN** | Состояние кластера неизвестно. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`.</li></ul>

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
