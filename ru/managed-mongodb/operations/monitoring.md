# Мониторинг состояния {{ MG }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#cluster}

Для просмотра детальной информации о состоянии кластера {{ mmg-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На странице появятся следующие графики:

* **Asserts total** — количество срабатываний [assert](https://docs.mongodb.com/manual/reference/command/serverStatus/#mongodb-serverstatus-serverstatus.asserts) в кластере.
* **Average operation time per host** — среднее время выполнения команд каждым хостом (в микросекундах).
* **Average operations time on primary** — среднее время выполнения команд на первичных репликах (в микросекундах).
* **Average operations time on secondaries** — среднее время выполнения команд на вторичных репликах (в микросекундах).
* **CPU usage per host** — степень использования vCPU на каждом хосте (в тысячных долях).
* **CPU usage per host, top 5 hosts** — 5 хостов с наибольшей утилизацией vCPU (в процентах).
* **Configured oplog size per host** — размер журнала операций (oplog) на каждом хосте кластера (в гигабайтах).
* **Connections per host** — среднее количество подключений к каждому хосту.
* **Data size on primary, top 5 databases** — размер пяти наибольших баз данных на первичной реплике (в байтах). На графике используются данные без [сжатия](../concepts/settings-list.md#setting-wired-tiger).
* **Disk read per host, top 5 hosts** — 5 хостов с наибольшей нагрузкой на чтение из дисковой подсистемы (байт/с).
* **Disk space usage per host, top 5 hosts** — 5 хостов с наибольшим использованием места в хранилище (выводится два графика: в байтах и в процентах). На графике используются данные после применения [сжатия](../concepts/settings-list.md#setting-wired-tiger).
* **Disk usage per host, top 5 hosts** — 5 хостов с наибольшей нагрузкой на подсистему I/O хранилища (байт/с).
* **Disk write per host, top 5 hosts** — 5 хостов с наибольшей нагрузкой на запись в дисковую подсистему (килобайт/с).
* **Documents affected on primary** — среднее количество затронутых запросами документов на первичной реплике.
* **Documents affected on secondaries** — среднее количество затронутых запросами документов на всех вторичных репликах.
* **Documents affected per host** — среднее количество документов, затронутое запросами на каждом хосте.
* **Hosts available for read** — количество хостов, принимающих запросы на чтение.
* **Hosts available for write** — количество хостов, принимающих запросы на запись.
* **Index size on primary, top 5 indexes** — размер пяти наибольших индексов на первичной реплике (в байтах).
* **Memory usage per host** — объем оперативной памяти, использованной каждым хостом (в байтах).
* **Memory usage per host, top 5 hosts** — 5 хостов с наибольшим использованием оперативной памяти (в процентах).
* **Network data received per host, top 5 hosts** — 5 хостов с наибольшей сетевой нагрузкой на чтение (килобайт/с).
* **Network data sent per host, top 5 hosts** — 5 хостов с наибольшей сетевой нагрузкой на запись (килобайт/с).
* **Network usage per host, top 5 hosts** — 5 хостов с наибольшей суммарной сетевой нагрузкой (килобайт/с).
* **Open cursors total** — количество открытых в кластере курсоров.
* **Oplog window** — временной диапазон, за который хранятся данные репликации в коллекции oplog каждого хоста.
* **Page faults per host** — количество [отказов страниц]({% if lang=="ru" %}https://ru.wikipedia.org/wiki/Отказ_страницы{% endif %}{% if lang =="en" %}https://en.wikipedia.org/wiki/Page_fault{% endif %}) на каждом хосте.
* **Queries on secondaries** — среднее количество запросов каждого типа, выполненных на вторичных репликах.
* **Queries on primary** — среднее количество выполненных на первичных репликах запросов каждого типа.
* **Read operations count, top 5 collections** — 5 коллекций с наибольшим количеством времени, затраченным на выполнение операций чтения.
* **Readers/writers active queue per host, top 5** — суммарный размер пяти наибольших очередей для каждого хоста:
    * с запросами на чтение;
    * с запросами на запись.
* **Replicated queries** — среднее количество реплицированных запросов в кластере.
* **Replication lag per host and write_concern wait** — задержки репликации на каждом хосте и ожидание [подтверждения записи](https://docs.mongodb.com/manual/reference/write-concern/) (в секундах).
* **Scan and order per host** — количество сортировок данных без использования индекса на каждом хосте.
* **Scanned / returned** — показывает соотношения:
    * `scanned_docs / returned_docs` — количество просканированных документов к количеству возвращенных;
    * `scanned_keys / returned_docs` — количество просканированных ключей индекса к количеству возвращенных документов.
* **TTL indexes activity** — общее количество [индексов TTL](https://docs.mongodb.com/manual/core/index-ttl/).
* **Total operations count on cluster** — общее количество выполненных в кластере операций.
* **Total operations time on cluster** — общее время выполнения операций в кластере (в миллисекундах).
* **WiredTiger cache pages evicted on primary** — среднее количество страниц оперативной памяти, вытесненных на первичной реплике.
* **WiredTiger cache state on primary** — использование кеша WiredTiger на первичной реплике (в байтах).
* **WiredTiger checkpoint time on primary** — время создания контрольных точек WiredTiger на первичной реплике (в миллисекундах).
* **WiredTiger concurrent transactions on primary** — среднее количество параллельных транзакций на первичной реплике.
* **WiredTiger transactions state on primary** — среднее количество транзакций каждого уровня на первичной реплике.
* **Write conflicts per host** — количество конфликтов записи на каждом хосте.
* **Write operations count, top 5 collections** — 5 коллекций с наибольшим количеством времени, затраченным на выполнение операций записи.

## Мониторинг состояния хостов {#hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mmg-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **Хосты** → **Мониторинги**.
1. Выберите нужный хост из выпадающего списка. Возле имени хоста будет показана его роль (`PRIMARY` или `SECONDARY`) и тип (`MONGOCFG`, `MONGOD`, `MONGOINFRA`, `MONGOS`).

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
* **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
* **Disk Bytes** — скорость дисковых операций (байт/с).
* **Disk IOPS** — интенсивность дисковых операций (операций/с).
* **Network Bytes** — скорость обмена данными по сети (байт/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

{% if audience != "internal" %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.

    1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.

    1. В блоке **Сервисные дашборды** выберите:

        * **{{ mes-name }}** для настройки алертов кластера;
        * **{{ mes-name }} — Host Overview** для настройки алертов хостов.

    1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.

    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).

    1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.

    1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                         | Обозначение                     | `Alarm`                  | `Warning`                |
|---------------------------------|:-------------------------------:|:------------------------:|:------------------------:|
| Доступность БД на запись        | `can_write`                     | `Равно 0`                | —                        |
| Задержка репликации             | `replset_status-replicationLag` | `180`                    | `30`                     |
| Объем использованного хранилища | `disk.used_bytes`               | 90% от размера хранилища | 70% от размера хранилища |

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-mongodb).

{% endif %}

### Отслеживание перехода в read-only {#read-only-alert}

Чтобы отслеживать степень заполнения хранилища на хостах кластера и получать уведомления в случае скорого исчерпания свободного места:

{% if audience == "external" %}
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).
{% else %}
1. Создайте алерт.
{% endif %}
1. Добавьте метрику состояния `disk.free_bytes`.

    Для этого создайте запрос в конструкторе запросов:

    `service={{ mmg-name }}` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Задайте в параметрах алерта значения порогов для оповещения:
   * **Условие срабатывания** — выберите условие `Меньше или равно` для размера свободного дискового пространства, при котором сработает алерт.

       Рекомендуемые значения порогов в зависимости от размера хранилища:
  
       | Размер хранилища, ГБ | `Alarm`     | `Warning`        |
       |---------------------|-------------|------------------|
       | ⩽ 600               | `1G` (1 ГБ) | `1500M` (1,5 ГБ) |
       | > 600               | `6G` (6 ГБ) | `10G` (10 ГБ)    |

   * **Дополнительные настройки** → **Функция агрегации** — выберите значение `Минимум` (минимальное значение метрики за период).

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mmg-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-mongodb`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `secondary`
shard | Идентификатор шарда

{% endcut %}

{% cut "Метрики CPU" %}

Загрузка процессорных ядер.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Метрики диска" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Метрики дисковых операций" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "Метрики RAM" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Метрики сети" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Метрики dbStats" %}

Собираются в разрезе каждой базы `<dbname>`, включая служебные (admin, config, local).

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `db_stats_avgObjSize`<br/>`DGAUGE`, байты | Средний размер документа. | 
| `db_stats_collections`<br/>`DGAUGE`, штуки | Количество коллекций в базе. | 
| `db_stats_dataSize`<br/>`DGAUGE`, байты | Размер несжатых данных в базе. | 
| `db_stats_fsTotalSize`<br/>`DGAUGE`, байты | Размер дискового пространства файловой системы, где MongoDB хранит данные. | 
| `db_stats_fsUsedSize`<br/>`DGAUGE`, байты | Размер использованного дискового пространства файловой системы, где MongoDB хранит данные. | 
| `db_stats_indexSize`<br/>`DGAUGE`, байты | Размер места, занимаемого индексами базы. | 
| `db_stats_indexes`<br/>`DGAUGE`, штуки | Количество индексов во всех коллекциях в базе. | 
| `db_stats_numExtents`<br/>`DGAUGE`, штуки | Количество логических контейнеров во всех коллекциях в базе. | 
| `db_stats_objects`<br/>`DGAUGE`, штуки | Количество объектов (документов) во всех коллекциях в базе. | 
| `db_stats_ok`<br/>`DGAUGE`, 0/1 | Результат выполнения команды dbStats.<br/>Принимает значение `1`, если команда завершена успешно, `0`, если что-то пошло не так. | 
| `db_stats_scaleFactor`<br/>`DGAUGE`, штуки | Параметр `scale`, используемый командой.  | 
| `db_stats_storageSize`<br/>`DGAUGE`, байты | Размер места, выделенного под хранение документов во всех коллекциях в базе, включая свободное место. | 
| `db_stats_views`<br/>`DGAUGE`, штуки | Количество представлений в базе. |

{% endcut %}

{% cut "Метрики serverStatus" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `server_status_admin_asserts.msg`<br/>`DGAUGE`, штуки | Количество срабатываний ассертов сообщений. | 
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний ассертов сообщений за секунду. | 
| `server_status_admin_asserts.regular`<br/>`DGAUGE`, штуки | Количество срабатываний регулярных ассертов. | 
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний регулярных ассертов за секунду. | 
| `server_status_admin_asserts.rollovers`<br/>`DGAUGE`, штуки | Количество переполнений счетчиков.  | 
| `server_status_admin_asserts.rollovers_rate`<br/>`DGAUGE`, штуки | Прирост переполнений счетчиков за секунду. | 
| `server_status_admin_asserts.user`<br/>`DGAUGE`, штуки | Количество срабатываний пользовательский ассертов.  | 
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний пользовательский ассертов за секунду. | 
| `server_status_admin_asserts.warning`<br/>`DGAUGE`, штуки | Количество предупреждений. | 
| `server_status_admin_asserts.warning_rate`<br/>`DGAUGE`, штуки | Прирост предупреждений за секунду. | 
| `server_status_admin_connections.active`<br/>`DGAUGE`, штуки | Количество активных подключений. | 
| `server_status_admin_connections.active_rate`<br/>`DGAUGE`, штуки | Прирост активных подключений за секунду. | 
| `server_status_admin_connections.adminConnections.readyThreads`<br/>`DGAUGE`, штуки | Количество подготовленных потоков. | 
| `server_status_admin_connections.adminConnections.readyThreads_rate`<br/>`DGAUGE`, штуки | Прирост подготовленных потоков за секунду.  | 
| `server_status_admin_connections.adminConnections.startingThreads`<br/>`DGAUGE`, штуки | Количество стартовавших потоков. | 
| `server_status_admin_connections.adminConnections.startingThreads_rate`<br/>`DGAUGE`, штуки | Прирост стартовавших потоков за секунду. | 
| `server_status_admin_connections.adminConnections.threadsRunning`<br/>`DGAUGE`, штуки | Количество запущенных потоков. | 
| `server_status_admin_connections.adminConnections.threadsRunning_rate`<br/>`DGAUGE`, штуки | Прирост запущенных потоков за секунду. | 
| `server_status_admin_connections.available`<br/>`DGAUGE`, штуки | Количество доступных для использования соединений. | 
| `server_status_admin_connections.available_rate`<br/>`DGAUGE`, штуки | Прирост доступных для использования соединений за секунду. | 
| `server_status_admin_connections.current`<br/>`DGAUGE`, штуки | Количество входящих соединений с БД. | 
| `server_status_admin_connections.current_rate`<br/>`DGAUGE`, штуки | Прирост входящих соединений с БД за секунду. | 
| `server_status_admin_connections.totalCreated`<br/>`DGAUGE`, штуки | Количество всех входящих соединений с сервером, включая завершенные. | 
| `server_status_admin_connections.totalCreated_rate`<br/>`DGAUGE`,число  | Прирост всех входящих соединений с сервером за секунду, включая завершенные. | 
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, штуки | Количетсов [отказов страниц](https://ru.wikipedia.org/wiki/Отказ_страницы). | 
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на чтение. | 
| `server_status_admin_globalLock.currentQueue.readers_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки на чтение, за секунду. | 
| `server_status_admin_globalLock.currentQueue.total`<br/>`DGAUGE`, штуки | Суммарное количество операций в очереди операций, ожидающих снятия блокировки. | 
| `server_status_admin_globalLock.currentQueue.total_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки, за секунду. | 
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на запись. | 
| `server_status_admin_globalLock.currentQueue.writers_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки на запись, за секунду. | 
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, штуки | Количество открытых курсоров с настройкой `DBQuery.Option.noTimeout` для предотвращения таймаута в случае неактивности. | 
| `server_status_admin_metrics.cursor.open.noTimeout_rate`<br/>`DGAUGE`, штуки | Прирост количества открытых курсоров с настройкой `DBQuery.Option.noTimeout` для предотвращения таймаута в случае неактивности за секунду. | 
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, штуки | Количество закрепленных открытых курсоров. | 
| `server_status_admin_metrics.cursor.open.pinned_rate`<br/>`DGAUGE`, штуки | Прирост закрепленных открытых курсоров за секунду. | 
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, штуки | Количество открытых курсоров. | 
| `server_status_admin_metrics.cursor.open.total_rate`<br/>`DGAUGE`, штуки | Прирост открытых курсоров за секунду.  | 
| `server_status_admin_metrics.cursor.timedOut`<br/>`DGAUGE`, штуки | Количество курсоров, достигших таймаута. | 
| `server_status_admin_metrics.cursor.timedOut_rate`<br/>`DGAUGE`, штуки | Прирост курсоров, достигших таймаута, за секунду. | 
| `server_status_admin_metrics.document.deleted`<br/>`DGAUGE`, штуки | Количество удаленных документов. | 
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов за секунду. | 
| `server_status_admin_metrics.document.inserted`<br/>`DGAUGE`, штуки | Количество вставленных документов. | 
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, штуки | Прирост вставленных документов за секунду. | 
| `server_status_admin_metrics.document.returned`<br/>`DGAUGE`, штуки | Количество возвращенных документов. | 
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, штуки | Прирост возвращенных документов за секунду. | 
| `server_status_admin_metrics.document.updated`<br/>`DGAUGE`, штуки | Количество обновленных документов. | 
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, штуки | Прирост обновленных документов за секунду. | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis`<br/>`DGAUGE`, миллисекунды | Число миллисекунд, которое БД потратила в ожидании подтверждения успешной записи. | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, миллисекунды | Прирост миллисекунд, которое БД потратила в ожидании подтверждения успешной записи, за секунду. | 
| `server_status_admin_metrics.operation.scanAndOrder`<br/>`DGAUGE`, штуки | Количество сортировок данных без использования индекса. | 
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, штуки | Прирост сортировок данных без использования индекса за секунду. | 
| `server_status_admin_metrics.operation.writeConflicts`<br/>`DGAUGE`, штуки | Количество конфликтов при записи. | 
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, штуки | Прирост конфликтов при записи за секунду. | 
| `server_status_admin_metrics.queryExecutor.scanned`<br/>`DGAUGE`, штуки | Количество просканированных ключей индекса. | 
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, штуки | Прирост просканированных ключей индекса за секунду. | 
| `server_status_admin_metrics.queryExecutor.scannedObjects`<br/>`DGAUGE`, штуки | Количество просканированных документов. | 
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, штуки | Прирост просканированных документов за секунду. | 
| `server_status_admin_metrics.ttl.deletedDocuments`<br/>`DGAUGE`, штуки | Количество удаленных документов с использованием [TTL индекса](https://www.mongodb.com/docs/manual/core/index-ttl/). | 
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов с использованием [TTL индекса](https://www.mongodb.com/docs/manual/core/index-ttl/) за секунду. | 
| `server_status_admin_metrics.ttl.passes`<br/>`DGAUGE`, штуки | Количество фоновых операций удаления документов из коллекций с использованием TTL индекса. | 
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, штуки | Прирост фоновых операций удаления документов из коллекций с использованием TTL индекса за секунду. | 
| `server_status_admin_opLatencies.commands.latency`<br/>`DGAUGE`, микросекунды | Суммарная задержка выполнения команд БД в микросекундах. | 
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд БД за секунду. | 
| `server_status_admin_opLatencies.commands.ops`<br/>`DGAUGE`, штуки | Количество операций над коллекциями БД. | 
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций над коллекциями БД за секунду. | 
| `server_status_admin_opLatencies.reads.latency`<br/>`DGAUGE`, микросекунды | Задержка выполнения команд чтения в микросекундах. | 
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд чтения за секунду. | 
| `server_status_admin_opLatencies.reads.ops`<br/>`DGAUGE`, штуки | Количество операций чтения коллекций БД. | 
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций чтения коллекций БД за секунду. | 
| `server_status_admin_opLatencies.transactions.latency`<br/>`DGAUGE`, микросекунды | Задержка транзакций в микросекундах. | 
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, микросекунды |Изменение задержки транзакций за секунду.  | 
| `server_status_admin_opLatencies.transactions.ops`<br/>`DGAUGE`, штуки | Количество транзакций в БД. | 
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, штуки | Прирост транзакций в БД за секунду. | 
| `server_status_admin_opLatencies.writes.latency`<br/>`DGAUGE`, микросекунды | Задержка выполнения команд записи в микросекундах. | 
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд записи за секунду. | 
| `server_status_admin_opLatencies.writes.ops`<br/>`DGAUGE`, штуки | Количество операций записи коллекций БД. | 
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций записи коллекций БД за секунду. | 
| `server_status_admin_opcounters.command`<br/>`DGAUGE`, штуки | Количество команд к БД с момента последнего старта. Кроме команд `insert`, `update`, `delete`. | 
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, штуки | Прирост количества команд к БД за секунду. Кроме команд `insert`, `update`, `delete`. | 
| `server_status_admin_opcounters.delete`<br/>`DGAUGE`, штуки | Количество `delete` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества `delete` операций в БД за секунду. | 
| `server_status_admin_opcounters.getmore`<br/>`DGAUGE`, штуки | Количество `getmore` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества `getmore` операций в БД за секунду. | 
| `server_status_admin_opcounters.insert`<br/>`DGAUGE`, штуки | Количество `insert` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества `insert` операций в БД за секунду. | 
| `server_status_admin_opcounters.query`<br/>`DGAUGE`, штуки | Количество `query` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, штуки | Прирост количества `query` операций в БД за секунду. | 
| `server_status_admin_opcounters.update`<br/>`DGAUGE`, штуки | Количество `update` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, штуки | Прирост количества `update` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.command`<br/>`DGAUGE`, штуки | Количество реплицируемых команд к БД с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых команд к БД за секунду. | 
| `server_status_admin_opcountersRepl.delete`<br/>`DGAUGE`, штуки | Количество реплицируемых `delete` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `delete` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.getmore`<br/>`DGAUGE`, штуки | Количество реплицируемых `getmore` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `getmore` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.insert`<br/>`DGAUGE`, штуки | Количество реплицируемых `insert` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `insert` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.query`<br/>`DGAUGE`, штуки | Количество реплицируемых `query` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `query` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.update`<br/>`DGAUGE`, штуки | Количество реплицируемых `update` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `update` операций в БД за секунду. | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, байты | Размер использованного кеша WiredTiger. | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache_rate`<br/>`DGAUGE`, байты | Прирост использованного кеша WiredTiger за секунду. | 
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction`<br/>`DGAUGE`, штуки | Количество освобожденных страниц при чекпоинте. | 
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных страниц при чекпоинте за секунду. | 
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, байты | Установленный максимальный размер кеша. | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted`<br/>`DGAUGE`, штуки | Количество освобожденных измененных страниц оперативной памяти. | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных измененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, байты | Размер грязного кеша. | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache_rate`<br/>`DGAUGE`, байты | Прирост грязного кеша за секунду. | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted`<br/>`DGAUGE`, штуки | Количество освобожденных неизмененных страниц оперативной памяти. | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных неизмененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out_rate`<br/>`DGAUGE`, штуки | Прирост задействованных тикетов параллельных транзакций чтения за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets_rate`<br/>`DGAUGE`, штуки | Прирост тикетов параллельных транзакций чтения за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out_rate`<br/>`DGAUGE`, штуки | Прирост задействованных тикетов параллельных транзакций записи за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets_rate`<br/>`DGAUGE`, штуки | Прирост доступных тикетов параллельных транзакций записи за секунду. | 
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, штуки | Количество запущенных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transaction_begins_rate`<br/>`DGAUGE`, штуки | Прирост запущенных транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, миллисекунды | Максимальное время создания чекпоинта. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, миллисекунды | Минимальное время создания чекпоинта. |  
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, миллисекунды | Время создания последнего чекпоинта (в миллисекундах). | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints`<br/>`DGAUGE`, штуки | Количество чекпоинтов транзакций. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints_rate`<br/>`DGAUGE`, штуки | Прирост чекпоинтов транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transactions_committed`<br/>`DGAUGE`, штуки | Количество завершенных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, штуки | Прирост завершенных транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back`<br/>`DGAUGE`, штуки | Количество отмененных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, штуки | Прирост отмененных транзакций за секунду. |

{% endcut %}

{% cut "Прочие метрики" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет.  | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет.  |
| `oplog-diff`<br/>`DGAUGE`, миллисекунды | Размер журнала операций (в миллисекундах). | 
| `oplog-firstTs`<br/>`DGAUGE`, миллисекунды | Таймстамп первой операции в журнале операций. | 
| `oplog-lastTs`<br/>`DGAUGE`, миллисекунды | Таймстамп последней операции в журнале операций. | 
| `oplog-maxSize`<br/>`DGAUGE`, байты | Максимальный размер журнала операций. | 
| `replset_status-replicationLag`<br/>`DGAUGE`, секунды | Задержка репликации. |

{% endcut %}

{% endif %}
