---
title: Мониторинг состояния кластера {{ maf-full-name }}
description: Из статьи вы узнаете, как отслеживать состояние кластера {{ maf-name }}.
---

# Мониторинг состояния кластера {{ maf-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Графики обновляются раз в минуту.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ maf-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

      На открывшейся странице будут отображены графики работы кластера {{ maf-name }}.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

### Доступные графики {#monitoring-dashboards}

* В блоке **Cluster**:

  * **CPU usage** — процент использования CPU компонентами кластера относительно их лимитов.
  * **Memory usage** — процент использования оперативной памяти компонентами кластера относительно их лимитов.
  * **Components Restarts** — количество перезапусков компонентов кластера.
  * **Components Count** — количество активных компонентов кластера.

* В блоке **DAGs**:

  * **DAG import stats** — метрики загрузки DAG-ов.
  * **DAG parse timings** — максимальное время обработки DAG-ов.
  
* В блоке **Tasks**:

  * **Tasks completed, 5m window** — количество завершенных задач с окном в пять минут.
  * **Tasks duration, p99** — 99-й процентиль времени выполнения задач.
  * **Tasks duration sum, 5m window** — суммарное время выполнения задач с окном в пять минут.
  
* В блоке **Resources**:

  * **Pool usage** — количество занятых слотов в каждом пуле кластера.

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ maf-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте пороговые значения `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-airflow-ref.md).

## Состояние и статус кластера

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. В строке нужного кластера наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

### Состояния кластера {#cluster-health}

Состояние | Описание | Предлагаемые действия
:--- | :--- | :---
**ALIVE** | Кластер работает в штатном режиме. | Действий не требуется.
**DEAD** | Кластер неработоспособен. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`.</li></ul>
**UNKNOWN** | Состояние кластера неизвестно. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`.</li></ul>

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}