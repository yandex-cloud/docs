---
title: Мониторинг состояния кластера {{ SPQR }} и хостов
description: Вы можете отслеживать состояние кластера {{ SPQR }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monitoring-full-name }} для автоматического мониторинга состояния кластера.
---

# Мониторинг состояния кластера {{ SPQR }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Чтобы посмотреть детальную информацию о состоянии кластера {{ mspqr-name }}:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.

1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На странице появятся следующие графики:

* В блоке **Cluster**:

    * **SPQR is Alive, \[boolean\]** — работоспособность [хостов-роутеров](../concepts/index.md#router).
    * **ETCD is Alive, \[boolean\]** — работоспособность [хостов-координаторов](../concepts/index.md#coordinator).
    * **Maximum CPU usage** — пиковая загрузка процессорных ядер.
    * **Average CPU usage** — средняя загрузка процессорных ядер.
    * **Maximum memory usage** — пиковое использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.

* **Sessions** → **Sessions count** — количество активных клиентских подключений к роутеру.

* **Connections** → **Backend connections count** — количество активных подключений от роутера к хостам [шардов](../concepts/index.md#shard).

* В блоке **Network**:

    * **Packets received/sent** — интенсивность обмена данными по сети (пакетов/с).
    * **Network received/sent bytes** — объем полученных и отправленных данных (в байтах).

* В блоке **Time quantiles**:

    * **Router time quantiles, ms** — время выполнения клиентских запросов к каждому роутеру в квантилях, заданных [настройкой](../concepts/settings-list.md) **Time Quantiles**.
    * **Shard time quantiles, ms** — время выполнения запросов от каждого роутера к хостам шардов в квантилях, заданных настройкой **Time Quantiles**.

## Мониторинг состояния хостов {#monitoring-hosts}

Чтобы посмотреть детальную информацию о состоянии отдельных хостов {{ mspqr-name }}:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг** → **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
1. Нажмите на строку нужного хоста в списке.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Packets received/sent** — интенсивность обмена данными по сети (пакетов/с).
* **Network received/sent bytes** — объем полученных и отправленных данных (в байтах).
* В блоке **Time quantiles**:
    * **Router time quantiles, ms** — время выполнения клиентских запросов к роутеру в квантилях, заданных [настройкой](../concepts/settings-list.md) **Time Quantiles**.
    * **Shard time quantiles, ms** — время выполнения запросов от роутера к хостам шардов в квантилях, заданных настройкой **Time Quantiles**.


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить автоматический мониторинг основных показателей состояния кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
    1. Перейдите в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. В блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}** выберите:
        * **{{ mspqr-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mspqr-name }} — Host Overview** для настройки алертов хостов.
    1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud.common.continue }}**. Подробнее о языке запросов [см. документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                         |   Обозначение   | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` | `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` |
|-------------------------------------------------|:---------------:|:-----------------------------------------------------------------------:|:----------------------------------------------------------------------:|
| Количество работоспособных хостов-роутеров      | `spqr-is-alive` |                   `<количество_хостов-роутеров> - 2`                    |                   `<количество_хостов-роутеров> - 1`                   |
| Количество работоспособных хостов-координаторов | `etcd-is-alive` |                 `<количество_хостов-координаторов> - 2`                 |                `<количество_хостов-координаторов> - 1`                 |


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Чтобы посмотреть состояние и статус кластера:

1. Перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
