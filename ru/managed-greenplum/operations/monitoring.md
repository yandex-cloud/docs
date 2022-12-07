# Мониторинг состояния {{ GP }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mgp-name }}:

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/monitoring.svg) **Мониторинг**.
    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Alive hosts** — работоспособность хостов кластера.

    * **Alive segments** — работоспособность первичного и резервного мастеров, основных и зеркальных сегментов.

    * **Connections** — количество подключений к БД в каждом из состояний:

        * **Active** — активные;
        * **Waiting** — ожидают;
        * **Idle** — простаивают;
        * **Idle in transaction** — простаивают в транзакции;
        * **Aborted** — прерванные.

    * **Group resource cpu** — загрузка процессорных ядер по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.

    * **Group resource memory** — использование оперативной памяти (в байтах) по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.

    * **Master** — определение первичного хоста-мастера.

    * **Master replication lag** — отставание репликации мастера (в байтах).

    * **Master replication state** — работоспособность репликации мастера.

    * **Segment health** — количество сегментов с различной работоспособностью:

        * **total** — все;
        * **not sync** — несинхронизированные;
        * **down** — недоступные;
        * **not prefer role** — непредпочтительные.

    * **Spill files count** — количество временных файлов.

    * **Spill files size** — суммарный размер временных файлов (в байтах).

    * **Xid wraparound** — использование [последовательности идентификаторов транзакций](https://docs.greenplum.org/6-16/admin_guide/managing/maintain.html) (в процентах).

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mgp-name }}:

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{mgp-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![hosts.svg](../../_assets/mdb/hosts.svg) **Хосты** → **Мониторинги**.
    1. Выберите нужный хост из выпадающего списка.

    На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера (мастер или сегмент):

    * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
    * **Disk IOPS in progress** — количество незавершенных дисковых операций.
    * **Disk io time** — длительность дисковых операций.
    * **Disk read and write** — объем дисковых операций (в байтах).
    * **Disk read and write time** — длительность дисковых операций чтения и записи.
    * **Disk usage** — использование дискового пространства (выводится два графика: в байтах и в процентах).
    * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
    * **Network** — объем данных, переданных по сети (в байтах).

{% endlist %}

{% if audience != "internal" %}

## Интеграция с {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
  1. В блоке **Сервисные дашборды** выберите:
      * **{{ mes-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mes-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если показателей на графике больше одного, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для оповещения.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-greenplum).

{% endif %}

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mgp-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-greenplum`
resource_type | Тип ресурса: `cluster`
resource_id | Имя кластера
cid | Bдентификатор кластера
host | FQDN хоста
fqdn | FQDN хоста

{% endcut %}

{% cut "Метрики CPU" %}

Загрузка процессорных ядер.

{% include [CPU](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Метрики диска" %}

Дополнительные метки: `device` — идентификатор диска в системе.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk-free`<br/>`DGAUGE`, байты | Свободное место. |
| `disk-inodes_free`<br/>`DGAUGE`, штуки | Свободное количество inodes. |
| `disk-inodes_total`<br/>`DGAUGE`, штуки | Доступное количество inodes. |
| `disk-inodes_used`<br/>`DGAUGE`, штуки | Использованное количество inodes. |
| `disk-total`<br/>`DGAUGE`, байты | Доступное место. |
| `disk-used`<br/>`DGAUGE`, байты | Использованное место. |
| `disk-used_percent`<br/>`DGAUGE`, % | Процент использованного места. |

{% endcut %}

{% cut "Метрики дисковых операций" %}

Дополнительные метки: `dev` - идентификатор диска в системе.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, миллисекунды | Длительность дисковых операций. | 
| `diskio.iops_in_progress`<br/>`DGAUGE`, штуки | Количество незавершенных дисковых операций. | 
| `diskio.merged_reads`<br/>`DGAUGE`, штуки | Количество слитых операций чтения с диска. | 
| `diskio.merged_writes`<br/>`DGAUGE`, штуки | Количество слитых операций записи на диск. | 
| `diskio.read_bytes`<br/>`DGAUGE`, байты | Объем чтения с диска. | 
| `diskio.read_time`<br/>`DGAUGE`, миллисекунды | Длительность чтения с диска. | 
| `diskio.reads`<br/>`DGAUGE`, штуки | Количество операций чтения с диска. | 
| `diskio.weighted_io_time`<br/>`DGAUGE`, миллисекунды | Длительность ожидания операций ввода/вывода. | 
| `diskio.write_bytes`<br/>`DGAUGE`, байты | Объем записи на диск.  | 
| `diskio.write_time`<br/>`DGAUGE`, миллисекунды | Длительнсть записи на диск. | 
| `diskio.writes`<br/>`DGAUGE`, штуки | Количество операций записи на диск. | 

{% endcut %}

{% cut "Метрики RAM" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `/System/memory/active`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `active`. | 
| `/System/memory/available`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `/System/memory/available_percent`<br/>`DGAUGE`, % | Процент доступной оперативной памяти. | 
| `/System/memory/buffered`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffered`. | 
| `/System/memory/cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. | 
| `/System/memory/commit_limit`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `commit_limit`. | 
| `/System/memory/committed_as`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `committed_as`. | 
| `/System/memory/dirty`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `dirty`. | 
| `/System/memory/free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `free`. | 
| `/System/memory/high_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_free`. | 
| `/System/memory/high_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_total`. | 
| `/System/memory/huge_page_size`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_page_size`. | 
| `/System/memory/huge_pages_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_free`. | 
| `/System/memory/huge_pages_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_total`. | 
| `/System/memory/inactive`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. | 
| `/System/memory/low_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_free`. | 
| `/System/memory/low_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_total`. | 
| `/System/memory/mapped`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `mapped`. | 
| `/System/memory/page_tables`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `page_tables`. | 
| `/System/memory/shared`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `/System/memory/slab`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. | 
| `/System/memory/sreclaimable`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. | 
| `/System/memory/sunreclaim`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. | 
| `/System/memory/swap_cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. | 
| `/System/memory/swap_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. | 
| `/System/memory/swap_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. | 
| `/System/memory/total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `/System/memory/used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `used`. | 
| `/System/memory/used_percent`<br/>`DGAUGE`, % | Процент использованной оперативной памяти. | 
| `/System/memory/vmalloc_chunk`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. | 
| `/System/memory/vmalloc_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. | 
| `/System/memory/vmalloc_used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. | 
| `/System/memory/write_back`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. | 
| `/System/memory/write_back_tmp`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |

{% endcut %}

{% cut "Метрики сети" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Метрики сервиса" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, штуки | Количество прерванных подключений к БД. | 
| `gp.conn_active`<br/>`DGAUGE`, штуки | Количество активных подключений к БД. | 
| `gp.conn_count`<br/>`DGAUGE`, штуки | Количество подключений к БД. | 
| `gp.conn_idle`<br/>`DGAUGE`, штуки | Количество простаивающих подключений к БД. | 
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, штуки | Количество простаивающих в состоянии незавершенной транзакции подключений к БД. | 
| `gp.conn_waiting`<br/>`DGAUGE`, штуки | Количество ожидающих в очереди подключений к БД. | 
| `gp.connect_percent`<br/>`DGAUGE`, % | Процент соединений. | 
| `gp.is_alive`<br/>`DGAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `gp.is_alive_segment`<br/>`DGAUGE` | Показатель работоспособности хоста-сегмента.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `gp.is_dead`<br/>`DGAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `0`, если хост БД работает, `1`, если нет. | 
| `gp.is_master`<br/>`DGAUGE` | Показатель типа хоста.<br/>Принимает значение `1`, если хост является мастер-хостом БД, `0`, если нет. | 
| `gp.master_replication_state`<br/>`DGAUGE` | Состояние репликации мастера. | 
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Использование последовательности идентификаторов транзакций.<br/>Дополнительные метки: `db_name` | 
| `gp.ping`<br/>`DGAUGE` | <br/>Дополнительные метки: `can_read`, `is_master`, `can_write`| 
| `gp.pxf_is_alive`<br/>`DGAUGE` | Показатель доступности расширения PXF. | 
| `gp.rg_cpu_used`<br/>`DGAUGE` | Распределение CPU по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.rg_mem_available`<br/>`DGAUGE` | Распределение доступной памяти по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.rg_mem_used`<br/>`DGAUGE` | Распределение использованной памяти по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.seg_count`<br/>`DGAUGE`, штуки | Количество сегментов в кластере. | 
| `gp.seg_down`<br/>`DGAUGE` | Недоступные сегменты. |
| `gp.seg_not_synch`<br/>`DGAUGE` | Несинхронизированные сегменты. | 
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, штуки | Число временных файлов на хост. | 
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, байты | Размер временных файлов на хост. |

{% endcut %}

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
