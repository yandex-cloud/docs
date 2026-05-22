---
title: Мониторинг состояния кластера, хостов и шардов в {{ mmg-name }}
description: Следуя данной инструкции, вы сможете посмотреть детальную информацию о состоянии кластера {{ mmg-name }}.
---

# Мониторинг состояния кластера, хостов и шардов в {{ mmg-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#cluster}

Для просмотра детальной информации о состоянии кластера {{ mmg-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}**.
      
      На открывшейся странице будут отображены графики, отражающие состояние кластера.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  Для кластера отображаются графики:

  * **Hosts available for write** — доступность хостов кластера для записи.
  * **Hosts available for read** — доступность хостов кластера для чтения.

  В блоке **Traffic**:

  * **Queries on primary** — прирост количества команд и операций на первичных репликах кластера.
  * **Queries on secondaries** — прирост количества команд и операций на вторичных репликах кластера.
  * **Replicated queries** — прирост количества реплицируемых команд и операций на вторичных репликах кластера.
  * **Documents affected on primary** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на первичных репликах кластера.
  * **Documents affected on secondaries** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на вторичных репликах кластера.
  * **Documents affected per host** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на каждом хосте кластера.
  * **Total operations count on cluster** — суммарный прирост количества команд и операций в кластере.
  * **Connections per host** — количество доступных и входящих подключений на каждом хосте кластера.
  * **Readers/writers active queue per host, top 5** — количество операций чтения и записи для пяти наибольших очередей, ожидающих снятия блокировки, на каждом хосте кластера.

  В блоке **Latency**:
   
  * **Average operations time on primary** — среднее время выполнения команд и операций на первичных репликах кластера.
  * **Average operations time on secondaries** — среднее время выполнения команд и операций на вторичных репликах кластера.
  * **Average operation time per host** — среднее время выполнения операций на каждом хосте кластера.
  * **Total operations time on Primaries** — суммарное время выполнения всех операций на первичных репликах кластера.
  * **Total operations time on Secondaries** — суммарное время выполнения всех операций на вторичных репликах кластера.
  * **Total operations time on Cluster** — суммарное время выполнения всех операций в кластере.
  * **Write operations time, top 5 collections** — суммарное время выполнения операций записи для пяти наибольших коллекций в кластере.
  * **Read operations time, top 5 collections** — суммарное время выполнения операций чтения для пяти наибольших коллекций в кластере.

  В блоке **DB Metrics**:

  * **Replication lag per host and write_concern wait** — время задержки репликации и ожидания подтверждения записи на каждом хосте кластера.
  * **Scanned / returned** — среднее соотношение сканированных ключей и документов к возвращенным документам в кластере.
  * **Scan and order per host** — прирост количества сортировок данных, не использующих индекс, на каждом хосте кластера.
  * **Data size on primary, top 5 databases** — объем данных для пяти баз с наибольшим размером на первичных репликах кластера.
  * **Index size on primary, top 5 indexes** — размер индексов для пяти баз с наибольшим размером на первичных репликах кластера.
  * **TTL indexes activity** — прирост удаленных документов и фоновых операций удаления с использованием TTL-индексов.
  * **Configured oplog size per host** — максимально возможный размер журнала операций на каждом хосте кластера.
  * **Oplog window** — временной интервал, за который хранятся данные репликации в коллекции oplog на каждом хосте кластера.
  * **Open cursors total** — количество открытых курсоров на хостах кластера. Отдельно отображаются:
    
    * общее количество курсоров;
    * закрепленные курсоры;
    * курсоры без таймаута.
  
  В блоке **Resources** → **CPU**:
  
  * **CPU usage per host** — процент использования CPU на каждом хосте кластера.
  * **CPU usage on Primaries** — доля использования CPU на первичных репликах кластера.
  * **CPU usage on Secondaries** — доля использования CPU на вторичных репликах кластера.
  
  В блоке **Resources** → **Memory**:
   
  * **Memory usage per host** — процент использования оперативной памяти на каждом хосте кластера.
  * **Memory usage on Primaries** — использование оперативной памяти на первичных репликах кластера.
  * **Memory usage on Secondaries** — использование оперативной памяти на вторичных репликах кластера.

  В блоке **Resources** → **Network**:

  * **Network usage per host** — суммарная сетевая нагрузка на каждом хосте кластера.
  * **Network data sent per host** — скорость отправки данных по сети на каждом хосте кластера.
  * **Network data received per host** — скорость получения данных по сети на каждом хосте кластера.

  В блоке **Resources** → **Disk**:
  
  * **Disk space usage per host** — использование дискового пространства на каждом хосте кластера, в процентах от общего объема хранилища.
  * **Disk space usage on Primaries** — использование дискового пространства на первичных репликах кластера.
  * **Disk space usage on Secondaries** — использование дискового пространства на вторичных репликах кластера.
  * **Disk usage per host** — суммарная скорость чтения и записи на диск на каждом хосте кластера.
  * **Disk write per host** — скорость записи на диск на каждом хосте кластера.
  * **Disk read per host** — скорость чтения с диска на каждом хосте кластера.

  В блоке **Errors**:

  * **Write conflicts per host** — прирост конфликтов записи на каждом хосте кластера.
  * **Page faults per host** — количество отказов страниц на каждом хосте кластера.
  * **Asserts total** — прирост количества срабатываний ассертов в кластере.

  В блоке **WiredTiger**:

  * **WiredTiger checkpoint time on primary** — время создания чекпоинтов на первичных репликах кластера.
  * **WiredTiger cache state on primary** — использование кеша на первичных репликах кластера.
  * **WiredTiger transactions state on primary** — прирост количества транзакций на первичных репликах кластера.
  * **WiredTiger concurrent transactions on primary** — текущее количество тикетов параллельных транзакций на первичных репликах кластера.
  * **WiredTiger cache pages evicted on primary** — прирост числа освобожденных страниц кеша (измененных и неизмененных) на первичных репликах кластера.
  
  В блоке **Mongos**:
   
  * **Mongos in balancer round** — участие Mongos в текущем раунде балансировки.
  * **Mongos active migrations** — максимальное количество активных операций миграции чанков через Mongos.
  * **Mongos migrations** — максимальное количество операций миграции чанков (успешных и неуспешных) через Mongos.

{% endlist %}

## Мониторинг состояния хостов {#hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mmg-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}**.
  1. Перейдите на вкладку **Хосты** и выберите хост.

      На открывшейся странице будут отображены графики, отражающие состояние хостов кластера.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  Для хостов отображаются графики:

  * **CPU usage** — процент использования CPU по типам потребления: `user`, `system`, `steal`, `softirq`, `nice`, `irq`, `iowait`, `idle`, `guest`.
  * **Memory usage** — использование оперативной памяти по типам потребления: `used`, `total`, `shared`, `free`, `cached`, `buffers`, `available`, `active`.
  * **Disk IOPS** — количество операций чтения и записи в секунду.
  * **Network bytes** — скорость отправки и получения данных по сети.
  * **Network packets** — интенсивность отправки и получения данных по сети (пакетов/с).
  * **Disk space usage** — занятое и доступное дисковое пространство.

  В блоке **Disk Metrics Details**:

  * **Disk write latency (percentiles)** — задержка записи на диск по процентилям.
  * **Disk write bytes** — средняя и максимальная скорость записи на диск.
  * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
  * **Disk read latency (percentiles)** — задержка чтения с диска по процентилям.
  * **Disk read bytes** — средняя и максимальная скорость чтения с диска.
  * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
  * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
  * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
  * **Disk used quota** — процент использования квоты для дисковых операций.

{% endlist %}

## Мониторинг состояния шардов {#monitoring-shards}

Для просмотра детальной информации о состоянии шардов {{ mmg-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_monitoring }}**.
  1. Перейдите на вкладку **Шарды** и выберите шард.
      
      На открывшейся странице будут отображены графики, отражающие состояние выбранного шарда и его хостов.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  Для шардов отображаются графики:

  * **Hosts available for write** — доступность хостов шарда для записи.
  * **Hosts available for read** — доступность хостов шарда для чтения.

  В блоке **Traffic**:

  * **Queries on primary** — прирост количества команд и операций на первичных репликах шарда.
  * **Queries on secondaries** — прирост количества команд и операций на вторичных репликах шарда.
  * **Replicated queries** — прирост количества реплицируемых команд и операций на вторичных репликах шарда.
  * **Documents affected on primary** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на первичных репликах шарда.
  * **Documents affected on secondaries** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на вторичных репликах шарда.
  * **Documents affected per host** — прирост количества вставленных, обновленных, удаленных или возвращенных запросами документов на каждом хосте шарда.
  * **Total operations count on cluster** — суммарный прирост количества команд и операций, выполненных на шарде.
  * **Connections per host** — количество доступных и входящих подключений на каждом хосте шарда.
  * **Readers/writers active queue per host, top 5** — количество операций чтения и записи для пяти наибольших очередей, ожидающих снятия блокировки, на каждом хосте шарда.

  В блоке **Latency**:
   
  * **Average operations time on primary** — среднее время выполнения команд и операций на первичных репликах шарда.
  * **Average operations time on secondaries** — среднее время выполнения команд и операций на вторичных репликах шарда.
  * **Average operation time per host** — среднее время выполнения операций на каждом хосте шарда.
  * **Total operations time on Primaries** — суммарное время выполнения всех операций на первичных репликах шарда.
  * **Total operations time on Secondaries** — суммарное время выполнения всех операций на вторичных репликах шарда.
  * **Total operations time on Cluster** — суммарное время выполнения всех операций на шарде.
  * **Write operations time, top 5 collections** — суммарное время выполнения операций записи для пяти наибольших коллекций на шарде.
  * **Read operations time, top 5 collections** — суммарное время выполнения операций чтения для пяти наибольших коллекций на шарде.

  В блоке **DB Metrics**:

  * **Replication lag per host and write_concern wait** — время задержки репликации и ожидания подтверждения записи на каждом хосте шарда.
  * **Scanned / returned** — среднее соотношение сканированных ключей и документов к возвращенным документам на шарде.
  * **Scan and order per host** — прирост количества сортировок данных, не использующих индекс, на каждом хосте шарда.
  * **Data size on primary, top 5 databases** — объем данных для пяти баз с наибольшим размером на первичных репликах шарда.
  * **Index size on primary, top 5 indexes** — размер индексов для пяти баз с наибольшим размером на первичных репликах шарда.
  * **TTL indexes activity** — прирост удаленных документов и фоновых операций удаления с использованием TTL-индексов на шарде.
  * **Configured oplog size per host** — максимально возможный размер журнала операций на каждом хосте шарда.
  * **Oplog window** — временной интервал, за который хранятся данные репликации в коллекции oplog на каждом хосте шарда.
  * **Open cursors total** — количество открытых курсоров на хостах шарда. Отдельно отображаются:
    
    * общее количество курсоров;
    * закрепленные курсоры;
    * курсоры без таймаута.
  
  В блоке **Resources** → **CPU**:
  
  * **CPU usage per host** — процент использования CPU на каждом хосте шарда.
  * **CPU usage on Primaries** — доля использования CPU на первичных репликах шарда.
  * **CPU usage on Secondaries** — доля использования CPU на вторичных репликах шарда.
  
  В блоке **Resources** → **Memory**:
   
  * **Memory usage per host** — процент использования оперативной памяти на каждом хосте шарда.
  * **Memory usage on Primaries** — использование оперативной памяти на первичных репликах шарда.
  * **Memory usage on Secondaries** — использование оперативной памяти на вторичных репликах шарда.

  В блоке **Resources** → **Network**:

  * **Network usage per host** — суммарная сетевая нагрузка на каждом хосте шарда.
  * **Network data sent per host** — скорость отправки данных по сети на каждом хосте шарда.
  * **Network data received per host** — скорость получения данных по сети на каждом хосте шарда.

  В блоке **Resources** → **Disk**:
  
  * **Disk space usage per host** — использование дискового пространства на каждом хосте шарда, в процентах от общего объема хранилища.
  * **Disk space usage on Primaries** — использование дискового пространства на первичных репликах шарда.
  * **Disk space usage on Secondaries** — использование дискового пространства на вторичных репликах шарда.
  * **Disk usage per host** — суммарная скорость чтения и записи на диск на каждом хосте шарда.
  * **Disk write per host** — скорость записи на диск на каждом хосте шарда.
  * **Disk read per host** — скорость чтения с диска на каждом хосте шарда.

  В блоке **Errors**:

  * **Write conflicts per host** — прирост конфликтов записи на каждом хосте шарда.
  * **Page faults per host** — количество отказов страниц на каждом хосте шарда.
  * **Asserts total** — прирост количества срабатываний ассертов на шарде.

  В блоке **WiredTiger**:

  * **WiredTiger checkpoint time on primary** — время создания чекпоинтов на первичных репликах шарда.
  * **WiredTiger cache state on primary** — использование кеша на первичных репликах шарда.
  * **WiredTiger transactions state on primary** — прирост количества транзакций на первичных репликах шарда.
  * **WiredTiger concurrent transactions on primary** — текущее количество тикетов параллельных транзакций на первичных репликах шарда.
  * **WiredTiger cache pages evicted on primary** — прирост числа освобожденных страниц кеша (измененных и неизмененных) на первичных репликах шарда.
  
  В блоке **Mongos**:
   
  * **Mongos in balancer round** — участие Mongos в текущем раунде балансировки на шарде.
  * **Mongos active migrations** — максимальное количество активных операций миграции чанков через Mongos на шарде.
  * **Mongos migrations** — максимальное количество операций миграции чанков (успешных и неуспешных) через Mongos на шарде.

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:

        * **{{ mmg-name }}** для настройки алертов кластера;
        * **{{ mmg-name }} — Host Overview** для настройки алертов хостов.

    1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для срабатывания алерта.
    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                         | Обозначение                     | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | `{{ ui-key.yacloud_monitoring.alert.status_warn }}` |
|---------------------------------|:-------------------------------:|:----------------------------------------------------:|:---------------------------------------------------:|
| Доступность БД на запись        | `can_write`                     | `Равно 0`                                            | —                                                   |
| Задержка репликации             | `replset_status-replicationLag` | `180`                                                | `30`                                                |
| Объем использованного хранилища | `disk.used_bytes`               | 90% от размера хранилища                             | 70% от размера хранилища                            |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байт (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `75161927680` байт (70%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-mongodb-ref.md).


### Отслеживание перехода в режим <q>только чтение</q> {#read-only-alert}

Чтобы отслеживать степень заполнения хранилища на хостах кластера и получать уведомления в случае скорого исчерпания свободного места:

1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).
1. Добавьте метрику состояния `disk.free_bytes`.

    Для этого создайте запрос в конструкторе запросов:

    `service=managed-mongodb` → `name=disk.free_bytes` → `host=*` → `resource_id=*` → `resource_type=cluster`.

1. Задайте в параметрах алерта значения порогов для оповещения:
   * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — выберите условие `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` для размера свободного дискового пространства, при котором сработает алерт.

       Рекомендуемые значения порогов в зависимости от размера хранилища:
  
       | Размер хранилища, ГБ | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`     | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`        |
       |---------------------|-------------|------------------|
       | ⩽ 600               | `1G` (1 ГБ) | `1500M` (1,5 ГБ) |
       | > 600               | `6G` (6 ГБ) | `10G` (10 ГБ)    |

   * **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}** → **{{ ui-key.yacloud_monitoring.service.field.function }}** — выберите значение `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (минимальное значение метрики за период).

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

