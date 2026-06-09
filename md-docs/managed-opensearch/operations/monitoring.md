# Мониторинг состояния кластера {{ OS }} и хостов

Данные о состоянии кластера и его хостов доступны в [консоли управления]({{ link-console-main }}). Их можно посмотреть на вкладке **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** страницы управления кластером  или в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Диагностическая информация о состоянии кластера представлена в виде графиков.

Новые данные для графиков поступают каждые {{ graph-update }}.

{% note info %}

На графиках автоматически применяются наиболее подходящие кратные единицы измерения (мегабайты, гигабайты и т. д.).

{% endnote %}

Вы можете [настроить алерты](#monitoring-integration) в сервисе {{ monitoring-full-name }} для получения уведомлений о сбоях в работе кластера. В {{ monitoring-full-name }} используются два порога срабатывания алерта: `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../monitoring/concepts/alerting.md#notification-channel).

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mos-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.

        На странице отображаются следующие графики:

        * В блоке **Cluster state**:

            * **Health status** — уровень работоспособности и техническое состояние кластера:

              * `0` (красный) — неработоспособное или частично работоспособное состояние. Хотя бы один из [первичных шардов](../concepts/scalability-and-resilience.md) недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.
              * `1` (желтый) — работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но работоспособность кластера нарушится, если появятся еще недоступные шарды.
              * `2` (зеленый) — исправное состояние. Все шарды кластера доступны.

            * **Current master** — FQDN одного из хостов с [ролью](../concepts/host-roles.md#data) `MANAGER`.
            * **Nodes** — общее количество хостов в кластере (кроме хостов `Dashboards`) и количество хостов с ролью `DATA`.
            * **Pending tasks** — количество задач в очереди.

        * В блоке **Indices and load info**:

            * **Top indices by size** — наиболее объемные индексы по занимаемому месту в хранилище и их размер (в байтах).
            * **Active shards** — количество активных первичных шардов и общее количество активных шардов в кластере.
            * **Search rate** — количество запросов поиска в секунду, для каждого хоста.
            * **Top indices by docs count** — индексы с наибольшим количеством документов и число документов в них.
            * **Other shards** — количество неактивных шардов в каждом из состояний:

              * `Delayed unassigned` — назначение хоста отложено;
              * `Unassigned` — нет назначенного хоста;
              * `Unassigned Primary` — нет назначенного хоста (только первичные шарды);
              * `Relocating` — перемещаются на другой хост;
              * `Initializing` — инициализируются.

            * **Indexing rate** — скорость индексирования, для каждого хоста (операций/с).

        * В блоке **Indices segments info**:

            * **Total indices segments per host** — количество сегментов индексов, для каждого хоста.

        * В блоке **Latest backup info**:

            * **Backup size** — размер самой новой резервной копии:

              * `backup_total_size` — общий размер всех индексов в резервной копии.
              * `backup_incremental_size` — размер индексов, входящих в инкремент резервной копии.
              * `backup_free_space_required` — объем хранилища, необходимый для восстановления кластера из резервной копии.

    {% note info %}

    Чтобы перейти к работе с метриками, дашбордами или алертами в сервисе {{ monitoring-name }}, нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** на панели сверху.

    {% endnote %}

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mos-name }}:

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
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

    * В блоке **Disk Metrics Details**:

      * **Disk write latency (percentiles)** — время записи на диск, по процентилям.
      * **Disk write bytes** — средняя и максимальная скорость записи на диск.
      * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
      * **Disk read latency (percentiles)** — время чтения с диска, по процентилям.
      * **Disk read bytes** — средняя и максимальная скорость чтения с диска.
      * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
      * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
      * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
      * **Disk used quota** — использование квоты для дисковых операций.

* DATA

    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ OS }}.
    * **Memory usage** — использование оперативной памяти (в байтах).
    * **JVM heap percent** — использование памяти кучи JVM (в процентах).
    * **Disk space usage percent** — использование дискового пространства (в процентах).
    * **Shards count** — количество шардов индексов.
    * **Primary shards count** — количество первичных шардов индексов.
    * **Open file descriptors** — количество открытых файловых дескрипторов.
    * **Indexing rate** — скорость индексирования (операций/с).
    * **Search queries** — количество запросов поиска в секунду.
    * **Write thread pool** — запросы индексации, удаления или обновления документов.
    * **Average query time** — среднее время выполнения запросов.
    * **Average indexing time** — среднее время, затраченное на индексацию документов.
    * **Thread pool queued** — количество запросов в очереди на выполнение.
    * **Thread pool rejected** — количество отклоненных запросов.
    * **Merging time** — время, затраченное на слияние документов.

    * В блоке **Disk Metrics Details**:

      * **Disk write latency (percentiles)** — время записи на диск, по процентилям.
      * **Disk write bytes** — средняя и максимальная скорость записи на диск.
      * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
      * **Disk read latency (percentiles)** — время чтения с диска, по процентилям.
      * **Disk read bytes** — средняя и максимальная скорость чтения с диска.
      * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
      * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
      * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
      * **Disk used quota** — использование квоты для дисковых операций.

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

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Выберите нужную группу хостов из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на группу хостов кластера. Набор графиков зависит от типа хостов в группе и аналогичен [набору графиков для отдельных хостов](#monitoring-hosts).


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. Перейдите в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
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

Чтобы настроить автоматический мониторинг других показателей состояния кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).
    1. Добавьте метрику состояния.
    1. В параметрах алерта задайте значения порогов для оповещения.

{% endlist %}

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

**{{ ui-key.yacloud.mdb.cluster.overview.label_health }}** кластера указывает на исправность его хостов, а **{{ ui-key.yacloud.mdb.cluster.overview.label_status }}** показывает, запущен кластер, остановлен или находится в промежуточном состоянии.

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать состояние и статус кластера, запросите информацию о нем:

    ```bash
    {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
    ```

    Состояние кластера указано в параметре `health`, статус кластера — в параметре `status`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

        Состояние и статус кластера указаны в параметрах `health` и `status`.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

        Состояние и статус кластера указаны в параметрах `health` и `status`.

{% endlist %}

### Состояния кластера {#cluster-health}

Состояние | Описание | Предлагаемые действия
:--- | :--- | :---
**ALIVE** | Кластер работает в штатном режиме. | Действий не требуется.
**DEGRADED** | Кластер работает не на полную мощность: минимум один из хостов имеет состояние, отличное от `ALIVE`. | Выполните диагностику:<ul><li>Перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** и посмотрите, какие из них в нерабочем состоянии.</li><li>Перейдите на вкладку **{{ ui-key.yacloud.common.operations-key-value }}** и убедитесь, что все операции завершились.</li><li>Убедитесь, что кластер не находится в процессе технического обслуживания.</li></ul>Если причины не удалось выяснить самостоятельно, [обратитесь в службу поддержки]({{ link-console-support }}).
**DEAD** | Кластер неработоспособен:  ни один его хост не работает. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `DEAD`.</li></ul>
**UNKNOWN** | Состояние кластера неизвестно. | [Составьте обращение в службу поддержки]({{ link-console-support }}), указав:<ul><li>Идентификатор кластера.</li><li>Идентификаторы последних операций, которые на нем выполнялись.</li><li>Время по [графикам доступности](#monitoring-cluster), когда кластер перешел в состояние `UNKNOWN`.</li></ul>

### Статусы кластера {#cluster-status}

Статус | Описание | Предлагаемые действия
:--- | :--- | :---
**CREATING** | Идет подготовка к первому запуску | Подождите немного и приступайте к работе. Время создания кластера зависит от класса хостов.
**RUNNING** | Кластер работает в штатном режиме | Действий не требуется.
**STOPPING** | Кластер останавливается | Через некоторое время кластеру будет присвоен статус `STOPPED`, и он будет выведен из работы. Действий не требуется.
**STOPPED** | Кластер остановлен | Запустите кластер, чтобы вернуть его в работу.
**STARTING** | Остановленный ранее кластер запускается | Через некоторое время кластеру будет присвоен статус `RUNNING`. Подождите немного и приступайте к работе.
**UPDATING** | Обновляется конфигурация кластера | По завершении обновления кластеру будет присвоен статус, который был до обновления: `RUNNING` или `STOPPED`.
**ERROR** | Произошла ошибка при выполнении операции с кластером или во время окна технического обслуживания | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки]({{ link-console-support }}). Доступность кластера можно определить по его состоянию.
**STATUS_UNKNOWN** | Кластер не может определить свой статус | Если кластер долго находится в этом статусе, [обратитесь в службу поддержки]({{ link-console-support }}).