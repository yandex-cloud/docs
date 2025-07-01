---
title: Как посмотреть детальную информацию о состоянии кластера {{ mes-name }}
description: Следуя данной инструкции, вы сможете посмотреть детальную информацию о состоянии кластера {{ mes-name }}.
---

# Мониторинг состояния кластера {{ ES }} и хостов

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mes-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Active shards** — количество активных [первичных шардов](../concepts/scalability-and-resilience.md) и общее количество активных шардов в кластере.
    * **Deletion rate** — количество операций удаления в секунду, для каждого хоста.
    * **Disk space usage percent** — использование дискового пространства, для каждого хоста (в процентах).
    * **Flushes** — количество операций сохранения лога транзакций (flush), для каждого хоста.

    * **Health status** — уровень работоспособности и техническое состояние кластера:

        * 0 — <q>красный</q>: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.
        * 1 — <q>желтый</q>: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.
        * 2 — <q>зеленый</q>: исправное состояние. Все шарды кластера доступны.

    * **Indexing rate** — интенсивность индексирования, для каждого хоста (операций/с).
    * **JVM heap** — использование памяти кучи JVM, для каждого хоста (в байтах).
    * **JVM heap pressure** — использование пула долгоживущих объектов JVM, для каждого хоста (в процентах).
    * **JVM old collections** — количество циклов сборки мусора в пуле долгоживущих объектов JVM, для каждого хоста.
    * **JVM young collections** — количество циклов сборки мусора в пуле новых объектов JVM, для каждого хоста.
    * **Merges** — количество слияний сегментов индексов, для каждого хоста.
    * **Nodes** — количество хостов с [ролью `Data node`](../concepts/hosts-roles.md) и общее количество хостов в кластере.
    * **Open file descriptors** — количество открытых файловых дескрипторов, для каждого хоста.
    * **Other shards** — количество неактивных шардов в каждом из состояний:

        * Delayed unassigned — назначение хоста отложено;
        * Unassigned — нет назначенного хоста;
        * Relocating — перемещаются на другой хост;
        * Initializing — инициализируются.

    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ ES }}, для каждого хоста.
    * **Query cache** — количество запросов в кеше, для каждого хоста.
    * **Read bytes** — скорость чтения с диска, для каждого хоста (байт/с).
    * **Read operations** — интенсивность чтения с диска, для каждого хоста (операций/с).
    * **Refreshes** — количество операций обновления сегментов индексов (refresh), для каждого хоста.
    * **Search queries** — количество запросов поиска в секунду, для каждого хоста.
    * **Segments** — количество сегментов индексов, для каждого хоста.
    * **Store size** — размер хранилища индексов на диске (в байтах).
    * **Write bytes** — скорость записи на диск, для каждого хоста (байт/с).
    * **Write operations** — интенсивность записи на диск, для каждого хоста (операций/с).

    {% note info %}

    {% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

    {% endnote %}

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mes-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
    1. Выберите нужный хост из выпадающего списка.

    На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

    * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
    * **Disk Bytes** — скорость дисковых операций (байт/с).
    * **Disk IOPS** — интенсивность дисковых операций (операций/с).
    * **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
    * **Network Bytes** — скорость обмена данными по сети (байт/с).
    * **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}** выберите:

      * **{{ ui-key.yacloud_monitoring.services.label_managed-elasticsearch }}** для настройки алертов кластера;
      * **{{ ui-key.yacloud_monitoring.services.label_managed-elasticsearch }} — Host Overview** для настройки алертов хостов.

  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов [см. документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                      |                Обозначение                |         Формула        |              `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`              |             `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}`             |
|----------------------------------------------|:-----------------------------------------:|:----------------------:|:---------------------------------:|:---------------------------------:|
| Статус кластера                              |           `elasticsearch_status`          |     `bottom_last(1)`   |              `равно 0`            |              `равно 1`            |
| Число неназначенных шардов                   |     `elasticsearch_unassigned_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число перемещаемых шардов                    |     `elasticsearch_relocating_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число инициализируемых шардов                |    `elasticsearch_initializing_shards`    |      `top_last(1)`     |             `больше 0`            |                                   |
| Число отложенных к назначению шардов         | `elasticsearch_delayed_unassigned_shards` |      `top_last(1)`     |             `больше 0`            |                                   |
| Объем использованной памяти кучи JVM         | `elasticsearch_jvm_mem_heap_used_percent` |      `top_last(1)`     | больше 90% от объема RAM на хосте |                                   |
| Объем использованного хранилища              |   `elasticsearch_fs_total_used_percent`   |      `top_last(1)`     |  больше 90% от размера хранилища  |  больше 85% от размера хранилища  |
| Использование пула долгоживущих объектов JVM |   `elasticsearch_jvm_mem_heap_pressure`   |      `top_last(1)`     | больше 90% от объема RAM на хосте | больше 75% от объема RAM на хосте |
| Размер использованного хранилища             | `disk.used_bytes`                         | —                      | 90% от размера хранилища          | 80% от размера хранилища          |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища и объем RAM на хостах можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **Managed Service for&nbsp;Elasticsearch**.
    1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

- API {#api}

    Воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

    Состояние и статус кластера будут указаны в параметрах `health` и `status`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

