---
title: Мониторинг состояния кластера {{ maf-full-name }}
description: Из статьи вы узнаете, как отслеживать состояние кластера {{ maf-name }}.
alternate:
  - href: ru/managed-airflow/operations/monitoring.md
    type: text/markdown
    title: Markdown version
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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-airflow) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
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

## Настройка алертов в {{ monium-full-name }} {#monitoring-integration}

Чтобы получать уведомления об изменении [показателей состояния кластера](#monitoring-cluster), создайте алерт по запросу с сервисного дашборда.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в который поступают метрики кластера.

      Метрики кластера передаются в проект {{ monium-name }} `folder__<идентификатор_каталога>`, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен этот кластер.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. Откройте дашборд **{{ maf-name }} — Cluster Overview**. Если на дашборде доступны параметры, выберите нужный кластер.
  1. На нужном графике нажмите ![rectangle-pulse](../../_assets/console-icons/rectangle-pulse.svg) **Перейти в Метрики**.
  1. На панели нужного запроса справа вверху нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Создать алерт по запросу** или **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
  1. Укажите название алерта. В блоке **Условия срабатывания** выберите запрос для проверки и задайте пороги **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** и **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.
  1. Чтобы получать уведомления, добавьте [канал уведомлений](../../monium/operations/alert/create-channel.md).
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик приведен в [справочнике метрик](../metrics.md).

## Состояние и статус кластера

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. [Перейдите]({{ link-console-main }}/link/managed-airflow) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. В строке нужного кластера наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

### Состояния кластера {#cluster-health}

Состояние | Описание | Предлагаемые действия
:--- | :--- | :---
**ALIVE** | Кластер работает в штатном режиме. | Действий не требуется.
**DEAD** | Кластер неработоспособен. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`.</li></ul>
**UNKNOWN** | Состояние кластера неизвестно. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`.</li></ul>

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
