# Мониторинг состояния кластера {{ OS }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mos-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

        На странице отображаются следующие графики:

        * **Health status** — уровень работоспособности и техническое состояние кластера:

            * `0` (красный) — неработоспособное или частично работоспособное состояние. Хотя бы один из [первичных шардов](../concepts/scalability-and-resilience.md) недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.
            * `1` (желтый) — работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.
            * `2` (зеленый) — исправное состояние. Все шарды кластера доступны.

        * **Active shards** — количество активных первичных шардов и общее количество активных шардов в кластере.
        * **Other shards** — количество неактивных шардов в каждом из состояний:

            * `Delayed unassigned` — назначение хоста отложено;
            * `Unassigned` — нет назначенного хоста;
            * `Relocating` — перемещаются на другой хост;
            * `Initializing` — инициализируются.

        * **Nodes** — количество хостов с [ролью](../concepts/host-roles.md#data) `DATA`.
        * **Segments** — количество сегментов индексов, для каждого хоста.
        * **Pending tasks** — количество задач в очереди.
        * **Indexing rate** — интенсивность индексирования, для каждого хоста (операций/с).
        * **Search rate** — количество запросов поиска в секунду, для каждого хоста.

    {% note info %}

    {% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

    {% endnote %}

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mos-name }}:

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Выберите нужный хост из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера. Набор графиков зависит от типа хоста:

{% list tabs %}

* MANAGER

    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ OS }}.
    * **Memory usage** — использование оперативной памяти (в байтах).
    * **JVM heap** — использование памяти кучи JVM (в байтах).
    * **Disk space usage percent** — использование дискового пространства (в процентах).
    * **Management thread pool** — количество запросов управления кластером.
    * **Generic thread pool** — количество запросов выполнения общих операций.
    * **Thread pool queued** — количество запросов в очереди на выполнение.
    * **Thread pool rejected** — количество отклоненных запросов.

* DATA

    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ OS }}.
    * **Memory usage** — использование оперативной памяти (в байтах).
    * **JVM heap percent** — использование памяти кучи JVM (в процентах).
    * **Disk space usage percent** — использование дискового пространства (в процентах).
    * **Indexing rate** — интенсивность индексирования (операций/с).
    * **Search queries** — количество запросов поиска в секунду.
    * **Open file descriptors** — количество открытых файловых дескрипторов.
    * **Write bytes** — скорость записи на диск (байт/с).
    * **Read bytes** — скорость чтения с диска (байт/с).
    * **Write thread pool** — запросы индексации, удаления или обновления документов.
    * **Write operations** — интенсивность записи на диск (операций/с).
    * **Read operations** — интенсивность чтения с диска (операций/с).
    * **Query time** — время, затраченное на выполнение запросов.
    * **Thread pool queued** — количество запросов в очереди на выполнение.
    * **Thread pool rejected** — количество отклоненных запросов.
    * **Indexing time** — время, затраченное на индексацию документов.
    * **Merging time** — время, затраченное на слияние документов.

* DASHBOARDS

    * **Is Alive** — статус доступности хоста.
    * **Requests Total** — общее число запросов к хостам.
    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ OS }}.
    * **Memory usage** — использование оперативной памяти (в байтах).
    * **Disk read/write bytes** — скорость дисковых операций (байт/с).
    * **Disk IOPS** — интенсивность дисковых операций (операций/с).
    * **Network Packets** — интенсивность обмена данными по сети (пакетов/с).
    * **Network Bytes** — скорость обмена данными по сети (байт/с).

{% endlist %}

## Мониторинг состояния групп хостов {#monitoring-host-groups}

Для просмотра детальной информации о состоянии группы хостов {{ mos-name }}:

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Выберите нужную группу хостов из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на группу хостов кластера. Набор графиков зависит от типа хостов в группе и аналогичен [набору графиков для отдельных хостов](#monitoring-hosts).


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:

      * **{{ mos-name }}** для настройки алертов кластера;
      * **{{ mos-name }} — Dashboards** для настройки алертов хостов с ролью `DASHBOARDS`;
      * **{{ mos-name }} — Data** для настройки алертов хостов с ролью `DATA`;
      * **{{ mos-name }} — Manager** для настройки алертов хостов с ролью `MANAGER`.

  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                      |                Обозначение             |         Формула        |              `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`              |             `{{ ui-key.yacloud_monitoring.alert.status_warn }}`             |
|----------------------------------------------|:--------------------------------------:|:----------------------:|:---------------------------------:|:---------------------------------:|
| Статус кластера                              |           `opensearch_status`          |     `bottom_last(1)`   |              `равно 0`            |              `равно 1`            |
| Число неназначенных шардов                   |     `opensearch_unassigned_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число перемещаемых шардов                    |     `opensearch_relocating_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число инициализируемых шардов                |    `opensearch_initializing_shards`    |      `top_last(1)`     |             `больше 0`            |                                   |
| Число отложенных к назначению шардов         | `opensearch_delayed_unassigned_shards` |      `top_last(1)`     |             `больше 0`            |                                   |
| Объем использованной памяти кучи JVM         | `opensearch_jvm_mem_heap_used_percent` |      `top_last(1)`     | больше 90% от объема RAM на хосте |                                   |
| Объем использованного хранилища              |   `opensearch_fs_total_used_percent`   |      `top_last(1)`     |  больше 90% от размера хранилища  |  больше 85% от размера хранилища  |
| Использование пула долгоживущих объектов JVM |   `opensearch_jvm_mem_heap_pressure`   |      `top_last(1)`     | больше 90% от объема RAM на хосте | больше 75% от объема RAM на хосте |
| Размер использованного хранилища             | `disk.used_bytes`                      | —                      | 90% от размера хранилища          | 80% от размера хранилища          |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища и объем RAM на хостах можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-opensearch-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы узнать состояние и статус кластера, запросите информацию о нем:

    ```bash
    {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
    ```

    Состояние кластера указано в параметре `health`, статус кластера — в параметре `status`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и передайте в запросе идентификатор удаляемого кластера в параметре `clusterId`.

    Состояние и статус кластера будут указаны в параметрах `health` и `status`.

    {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}
