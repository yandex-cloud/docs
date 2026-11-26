---
title: Мониторинг состояния кластера {{ myt-name }}
description: Из статьи вы узнаете, как осуществлять мониторинг состояния кластера {{ myt-name }}.
---

# Мониторинг состояния кластера {{ myt-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Графики обновляются раз в 15 секунд.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ myt-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-ytsaurus) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице отображаются две вкладки **Cluster** и **Master** с графиками:

  * **Automaton thread CPU usage** — загрузка CPU потоком Automaton, основным исполняющим потоком мастера (в процентах).
    * **TOTAL** — суммарная загрузка по всем master-нодам.
    * **ms-N** — загрузка потоком Automaton на master-ноде N.
  * **User write time** — время, затраченное на операции записи от пользователя.
    * **root** — время, затраченное на операции записи от пользователя root.
    * **robot-odin** — время, затраченное на операции записи от пользователя robot-odin.
    * **scheduler** — время, затраченное на операции записи от планировщика.
    * **tablet_cell_changelogger** — время, затраченное на операции записи от tablet_cell_changelogger.
  * **User read time** — время, затраченное на операции чтения от пользователя.
    * **tablet_cell_changelogger** — время, затраченное на операции чтения от tablet_cell_changelogger.
    * **root** — время, затраченное на операции чтения от пользователя root.
    * **operations_client** — время, затраченное на операции чтения от клиентского пользователя.
  * **Master memory usage** — использование памяти мастером (в ГБ).
    * **ms-N** — использование памяти на master-ноде N.
  * **LocalRead thread CPU usage** — загрузка CPU потоком LocalRead.
    * **TOTAL** — суммарная загрузка по всем master-нодам (в процентах).
    * **ms-N** — загрузка потока LocalRead на master-ноде N.
  * **User write request rate** — частота запросов на запись от пользователя (записей в секунду).
    * **root** — частота запросов на запись от пользователя root.
    * **robot-odin** — частота запросов на запись от пользователя robot-odin.
    * **scheduler** — частота запросов на запись от планировщика.
    * **tablet_cell_changelogger** — частота запросов на запись от tablet_cell_changelogger.
  * **User read request rate** — частота запросов на чтение от пользователя (чтений в секунду).
    * **root** — частота запросов на чтение от пользователя root.
    * **queue_agent** — частота запросов на чтение от пользователя queue_agent.
    * **operations_client** — частота запросов на чтение от клиентского пользователя.
  * **Create chunk requests** — количество запросов на создание чанков (запросов в секунду).
    * **TOTAL** — суммарное количество запросов на создание чанков от всех пользователей.
    * **root** — количество запросов на создание чанков от пользователя root.
    * **robot-odin** — количество запросов на создание чанков от пользователя robot-odin.
    * **scheduler** — количество запросов на создание чанков от планировщика.
    * **tablet_cell_snapshotter** — количество запросов на создание чанков от пользователя tablet_cell_snapshotter.
  * В блоке **Compute resources**:
    * **CPU distributed vs total** — общее и распределенное количество ресурсов CPU в кластере.
      * **distributes_resources** — количество распределенных ресурсов CPU.
      * **total_cluster_resources** — общее количество ресурсов CPU в кластере.
    * **GPU distributed vs total** — общее и распределенное количество ресурсов GPU в кластере..
      * **distributes_resources** — количество распределенных ресурсов GPU.
      * **total_cluster_resources** — общее количество ресурсов GPU в кластере.
    * **Memory distributed vs total** — общее и распределенное количество ресурсов памяти в кластере.
      * **distributes_resources** — количество распределенных ресурсов памяти.
      * **total_cluster_resources** — общее количество ресурсов памяти в кластере.
    * **Undistributed resources** — количество нераспределенных ресурсов.
      * **memory** — количество нераспределенных ресурсов памяти.
      * **cpu** — количество нераспределенных ресурсов CPU.
  * В блоке **Scheduler pools**:
    * **CPU: usage, demand, guarantee** — использование, запрос и гарантия ресурсов CPU.
      * **usage** — количество используемых ресурсов CPU.
      * **demand** — количество запрошенных ресурсов CPU.
      * **guarantee** — количество гарантированных ресурсов CPU.
    * **RAM: usage, demand, guarantee** — использование, запрос и гарантия ресурсов RAM.
      * **usage** — количество используемой памяти.
      * **demand** — количество запрошенной памяти.
      * **guarantee** — количество гарантированной памяти.
    * **GPU: usage, demand, guarantee** — использование, запрос и гарантия ресурсов GPU.
      * **usage** — количество используемых ресурсов GPU.
      * **demand** — количество запрошенных ресурсов GPU.
      * **guarantee** — количество гарантированных ресурсов GPU.
    * **Running operation count** — количество выполняющихся операций в статусе `running`.
      * **lightweight usage** —  количество lightweight-операций в статусе `running`.
      * **usage** — количество операций в статусе `running`.
    * **Total operation count** — общее количество операций.
      **limit** — максимально допустимое количество операций.
      **usage** — количество используемых операций.
  * В блоке **Problems**:
    * **Offline nodes** — ноды в статусе `offline`.
    * **Banned nodes** — ноды в статусе `banned`.
    * **Decomissioned nodes** — ноды в состоянии `decommissioned`.
    * **Alerts** — количество активных предупреждений о проблемах на нодах кластера {{ ytsaurus-name }}.

{% endlist %}

## Настройка алертов в {{ monium-full-name }} {#monitoring-integration}

Для настройки алертов нужны роли на каталог с кластером:

* [monium.metrics.reader](../../monium/security/index.md#monium-metrics-reader) — для чтения метрик.
* [monium.alerts.editor](../../monium/security/index.md#monium-alerts-editor) — для создания алертов.

Чтобы получать уведомления, при необходимости [создайте канал уведомлений](../../monium/operations/alert/create-channel.md) в проекте каталога с кластером. Для создания канала нужна роль [monium.channels.editor](../../monium/security/index.md#monium-channels-editor) на этот каталог.

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите]({{ link-console-main }}/link/managed-ytsaurus) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.
  1. На странице с графиками нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** на панели сверху. Графики откроются на платформе {{ monium-full-name }}.
  1. Убедитесь, что на панели сверху выбран проект каталога с кластером: `folder__<идентификатор_каталога>`. В этом проекте будет создан алерт.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Укажите название алерта, выберите тип **Пороговый** и проверьте запрос, перенесенный с графика.
  1. В блоке **Условия срабатывания** задайте условия и пороги **Warning** и **Alarm**.
  1. В блоке **Уведомления** выберите канал и статусы, при которых нужны уведомления.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Подробнее о настройке алертов читайте в [инструкции](../../monium/operations/alert/create-alert.md), о языке запросов — в разделе [{#T}](../../monium/concepts/querying.md).

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик — в [справочнике метрик {{ myt-name }}](../metrics.md).

## Статус кластера {#cluster-health-and-status}

_{{ ui-key.yacloud.mdb.cluster.overview.label_status }}_ показывает, запущен кластер, остановлен или находится в промежуточном состоянии.

Для просмотра статуса кластера:

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. [Перейдите]({{ link-console-main }}/link/managed-ytsaurus) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. В строке нужного кластера найдите столбец **{{ ui-key.yacloud.common.label_status }}**.

#|
|| **Статус** | **Описание** | **Предлагаемые действия** ||
|| **CREATING** | Идет подготовка к первому запуску | Подождите немного и приступайте к работе. Время создания кластера зависит от класса хостов. ||
|| **RUNNING** | Кластер работает в штатном режиме | Действий не требуется. ||
|| **STOPPING** | Кластер останавливается | Через некоторое время кластеру будет присвоен статус `STOPPED`, и он будет выведен из работы. Действий не требуется. ||
|| **STOPPED** | Кластер остановлен | Запустите кластер, чтобы вернуть его в работу. ||
|| **STARTING** | Остановленный ранее кластер запускается | Через некоторое время кластеру будет присвоен статус `RUNNING`. Подождите немного и приступайте к работе. ||
|| **UPDATING** | Обновляется конфигурация кластера | По завершении обновления кластеру будет присвоен статус, который был до обновления: `RUNNING` или `STOPPED`. ||
|| **DELETING** | Кластер удаляется | По завершении удаления кластера он будет выведен из работы. Действий не требуется. ||
|| **ERROR** | Произошла ошибка при выполнении операции с кластером или во время окна технического обслуживания | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки]({{ link-console-support }}). ||
|| **STATUS_UNKNOWN** | Кластер не может определить свой статус | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки]({{ link-console-support }}). ||
|#
