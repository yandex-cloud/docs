---
title: Мониторинг состояния кластера {{ GP }} и хостов
description: Следуя этой инструкции, вы сможете получить детальную информацию о состоянии кластера {{ GP }}.
---

# Мониторинг состояния кластера {{ GP }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
      
        На открывшейся странице будут отображены графики работы кластера {{ GP }}.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Connections** — количество подключений к БД в каждом из состояний:

        * **Active** — активные;
        * **Waiting** — ожидают;
        * **Idle** — простаивают;
        * **Idle in transaction** — простаивают в транзакции;
        * **Aborted** — прерванные.
    
    * **Segment health** — количество сегментов с различной работоспособностью:

        * **total** — все;
        * **not sync** — несинхронизированные;
        * **down** — недоступные;
        * **not prefer role** — непредпочтительные.
    
    * **Xid wraparound** — использование [последовательности идентификаторов транзакций]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound) (в процентах).
    * **Master replication lag** — отставание репликации мастера (в байтах).
    * **Master replication state** — работоспособность репликации мастера.
    * **Spill files size** — суммарный размер временных файлов (в байтах).
    * **Spill files count** — количество временных файлов.
    * **Group resource memory** — использование оперативной памяти (в байтах) по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.

    * **Group resource cpu** — загрузка процессорных ядер по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.
    
    * **Master** — определение первичного хоста-мастера.
    * **Alive hosts** — работоспособность хостов кластера.
    * **Alive segments** — работоспособность первичного и резервного мастеров, основных и зеркальных сегментов.
    * **Connection pooler**:
        
        * **Client connections** — количество свободных и занятых клиентских соединений в пуле.
        * **Server connections** — количество свободных и занятых серверных соединений в пуле.
        * **TCP connections** — количество TCP-соединений в пуле.

    * **Background activities**:
    
        * Обслуживание таблиц:

          * **Tables vacuum age** — количество пользовательских таблиц, [очистка](../concepts/maintenance.md#custom-table-vacuum) которых выполнялась N дней назад.
          * **Tables analyze age** — количество пользовательских таблиц, [сбор статистики](../concepts/maintenance.md#get-statistics) для которых выполнялся N дней назад.
          * **Expansion progress** — ход [процесса перераспределения данных](../concepts/expand.md#redistribution) при расширении кластера:

            * **Tables** — процент обработанных таблиц.
            * **Bytes** — процент перераспределенных байт данных.

            {% note info %}

            Этот график показывает ход процесса, даже если перераспределение данных было запущено не в виде [фонового процесса](../concepts/expand.md#setting-delay-redistribution).

            {% endnote %}
        
        * Статистика bloat системного каталога:

          * **Total catalog size** — размер каталога по всем сегментам.
          * **Number of dead tuples for segments** — количество `dead_tuple` в таблице `pg_attribute` по всем сегментам.
          * **Interval from the last vacuum time for segments** — время с последнего vacuum таблицы `pg_attribute` среди всех сегментов.

          На графиках показаны не все [метрики bloat](../metrics.md#managed-greenplum-bloat-metrics). Графики для остальных метрик вы можете построить самостоятельно.
          
          > Например, чтобы получить количество `live_tuple` в каталоге на мастере, [выполните запрос](../../monitoring/operations/metric/metric-explorer.md#add-graph):
          >
          > `alias(series_max("gp_vacuum.pg_attribute_live_tuples_master"{folderId = "b1g4unjqq856********", service = "managed-greenplum", resource_id = "c9q35r4odgeb********"}), "not_var{{ database }}")`
          
          Список доступных метрик см. в разделе [{#T}](../metrics.md#managed-greenplum-bloat-metrics).

    * **Test Queries Execution Time**:
        
        * **Read from cluster** — скорость чтения данных.
        * **Write to cluster** — скорость записи данных.
        * **Read from each segment** — скорость чтения для каждого сегмента кластера.
    
    * **Hybrid Storage**:
        
        * **Objects count** — количество объектов в базе данных.
        * **Total objects size, bytes** — суммарный размер объектов в базе данных (в байтах).

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
    1. Выберите нужный хост.

        На открывшейся странице будут отображены графики состояния конкретного хоста кластера.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:
    
    * **Disk usage** — объем занятого дискового пространства (в байтах).
    * **Load Average** — средняя нагрузка процессорных ядер за 1 минуту, 5 минут и 15 минут.
    * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
    * **Virtual memory usage** — использование вирутуальной памяти (в байтах).
    * **Disk Await** — среднее время дисковых операций.
    * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
    * **Disk IOPS** — количество дисковых операций в секунду.
    * **Network Bytes** — скорость обмена данными по сети.
    * **Disk IOPS in progress** — количество незавершенных дисковых операций.
    * **Network Packets** — интенсивность обмена данными по сети.
    * **Disk Metrics Details**:
      * **Disk used quota** — использование квоты для дисковых операций.
      * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
      * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
      * **Disk read latency (percentiles)** — время чтения с диска, по процентилям.
      * **Disk write latency (percentiles)** — время записи на диск, по процентилям.
      * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
      * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
      * **Disk read bytes** — средняя и максимальная скорость чтения с диска.
      * **Disk write bytes** — средняя и максимальная скорость записи на диск.

{% endlist %}

## Мониторинг состояния сети {#monitoring-network}

Для просмотра детальной информации о состоянии сети каждого хоста кластера {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_network }}**.

        На открывшейся странице будут отображены графики состояния сети каждого хоста кластера.

        {% note info %}
        
        Вы можете выбрать хост, чтобы посмотреть графики состояния сети только одного хоста.

        {% endnote %}

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Interfaces**:
        * **Сlient Interface Packets** — число полученных и отправленных пакетов на клиентском сетевом интерфейсе.
        * **Service Interface Packets** — число полученных и отправленных пакетов на сервисном сетевом интерфейсе.
        * **Сlient Interface Bytes** — объем полученных и отправленных данных на клиентском сетевом интерфейсе (в байтах).
        * **Service Interface Bytes** — объем полученных и отправленных данных на сервисном сетевом интерфейсе (в байтах).
        * **Client Interface Drops and Errors** — число ошибок и отброшенных пакетов при отправке и передаче на клиентском сетевом интерфейсе.
        * **Service Interface Drops and Errors** — число ошибок и отброшенных пакетов при отправке и передаче на сервисном сетевом интерфейсе.

    * **CPU**:
        * **Cpu Usage** — использование процессорных ядер (в процентах).

    * **Ping and SSH response time**:
        * **Host Ping Average Response** — среднее время ответа пинга (в миллисекундах).
        * **Host SSH Response Time** — время ответа при подключении через SSH (в миллисекундах).
        * **Host Ping Packet Loss** — потерянные пакеты пинга (в процентах).
        
    * **TCP counters**:
        * **TcpActiveConnection** — число активных TCP-соединений в состоянии `ESTABLISHED` или `CLOSE-WAIT`.
        * **TcpEstabResets** — число раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `ESTABLISHED`, либо из состояния `CLOSE-WAIT`.
        * **TCP Errors** — число ошибок при передаче TCP-пакетов.
        * **TCP Retransmission** — число TCP-пакетов, переданных повторно.

    * **ICMP Counters**:
        * **IcmpErrors** — число ICMP-сообщений об ошибках.
        * **IcmpDestUnreached** — число ICMP- и ICMPv6-сообщений о недоступности назначения.
        * **Icmp6PacketsTooBig** — число ICMPv6-сообщений о слишком больших пакетах.

    * **UDP counters**:
        * **UdpSndbufErrors** — число ошибок буфера при отправке UDP-пакетов.
        * **UdpRcvbufErrors** — число ошибок буфера при приеме UDP-пакетов.
        * **UDP Datagrams** — число UDP-пакетов.
        * **UDP NoPorts** — число принятых UDP-пакетов, для которых на порте назначения не было слушателя.

    * **IP**:
        * **IpMulticastPackets** — число полученных и отправленных многоадресных пакетов.
        * **IpBroadcastPackets** — число полученных и отправленных широковещательных пакетов.
        * **Ip6 Neighbor Discovery** — число отправленных запросов и объявлений маршрутизаторов.
        * **Ip6NoRoutes** — число IPv6-пакетов, сброшенных из-за отсутствия маршрута.

{% endlist %}

## Мониторинг PXF {#monitoring-pxf}

Для просмотра детальной информации о состоянии [PXF](external-tables.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }}**.

        На открывшейся странице будут отображены графики состояния PXF.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Liveness** — состояние PXF на хостах.
    * **JVM memory** — использование памяти JVM PXF (в ГБ).
    * **JVM Threads** — число потоков JVM PXF.
    * **Connections** — число подключений.
    * **PXF threads** — число потоков PXF.
    * **PXF Busy threads** — число занятых потоков PXF.
    * **Log messages** — число сообщений типа `warn`, `trace`, `info`, `fatal`, `error` и `debug`.
    * **Sent data** — объем отправленных данных.
    * **Received data** — объем полученных данных.
    * **File handles** — число файлов, открытых в процессе PXF.
    * **Sent records** — число записей, отправленных PXF.
    * **Received records** — число записей, полученных PXF.

{% endlist %}


## Мониторинг через дашборд {#monitoring-dashboard}

Для просмотра дашборда кластера {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Дашборд**.

        На открывшейся странице будут отображены графики дашборда кластера.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Running queries**:
        * **Test write query** — время выполнения тестовой записи с использованием политики `DISTRIBUTED REPLICATED`.
        * **Test read query** — время выполнения тестового запроса на чтение со случайного сегмента.
        * **Overall cluster's query execution time** — гистограмма времени выполнения запросов в кластере.

    * **Cluster liveliness**:
        * **Cluster sessions** — количество сессий в состояниях:
            * **active** — выполняют запрос;
            * **waiting** — ожидают команды;
            * **idle in transaction** — транзакция начата, но выполнение запроса не происходит (например, не сделали `COMMIT`).
        * **Number of live segments** — количество запущенных экземпляров сегментов, включая зеркала.
        * **Queries sent to the cluster**  — количество принятых и прерванных (отмененных) запросов.

    * **Segments health**:
        * **Idle CPU** — неиспользуемый ресурс CPU по хостам-сегментам. Чем меньше значение, тем выше загрузка хостов.
        * **Reserved memory** — использование оперативной памяти (в байтах) по хостам-сегментам. Во избежание ошибок необходимо поддерживать значение в пределах лимита.
        * **IOPS** — объем дисковых операций (в байтах) суммарно со всех хостов-сегментов.
        * **Number of network packets** — количество полученных и отправленных пакетов на сетевых интерфейсах по хостам-сегментам. Приближение к лимиту может привести к задержке в выполнении запросов.
        * **Number of network packets in queues** — количество пакетов в очереди на сетевых интерфейсах по хостам-сегментам. Приближение к лимиту может привести к задержке в выполнении запросов.
        * **Network traffic** — утилизация пропускной способности входящего сетевого потока по хостам-сегментам. Приближение к лимиту может привести к задержке в выполнении запросов.
        * **Ping time** — время выполнения пинга с хоста-мастера к хостам-сегментам кластера.
        * **Query execution time per segment** — суммарное время, потраченное на выполнение фрагментов (slice) запросов на каждом из хостов-сегментов кластера.

    * **Database internal metrics**:
        * **Free memory for resource groups** — доступная оперативная память по [ресурсным группам](../concepts/resource-groups.md).
        * **Summary CPU usage for resource groups** — суммарное использование CPU ресурсными группами на кластере. Может быть больше 100%, т. к. собирается со всех хостов кластера.
        * **CPU throttle time for cgroups** — время, в течение которого процессам ресурсной группы не выделяется время CPU из-за его полной утилизации (по хостам). При возрастании показателя на порядки (с миллисекунд до минут) может привести к задержке в выполнении запросов.
        * **Summary spill size** — суммарный размер временных (spill) файлов, образованных в результате нехватки RAM.
        * **Interconnect quality** — процент повторных передач пакетов между сегментами (трафик [{{ GP }} Interconnect]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-intro-arch_overview.html#arch_interconnect)) в общем объеме отправляемых пакетов с каждого хоста-сегмента. Чем больше показатель, тем менее стабильно работает сеть.
        * **Background activity - the number of sessions** — количество системных сессий на каждом сегменте в состояниях:
            * **active** — выполняют запрос;
            * **idle** — ожидают команды;
            * **aborted** — завершились ошибкой.
        * **Background activity - the longest query** — время выполнения самого долгого системного запроса на каждом из сегментов.

{% endlist %}

## Мониторинг ресурсных групп {#monitoring-resgroup}

Для просмотра информации по ресурсным группам {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Ресурсные группы**.
      
        На открывшейся странице будут отображены графики работы ресурсных групп.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:
 
    * **CPU Usage** — суммарная по всем хостам утилизация CPU в ресурсной группе.
    * **Memory Usage** — суммарная по всем хостам утилизация памяти в ресурсной группе.
    * **Running queries** — текущее количество активных транзакций, выполняющихся в ресурсной группе.
    * **Queueing queries** — текущее количество транзакций, находящихся в очереди для данной ресурсной группы.
    * **Executed queries** — общее количество транзакций, выполненных в ресурсной группе с момента последнего запуска кластера (за исключением **Running queries**).
    * **Queued queries** — общее количество транзакций, которые были поставлены в очередь для данной ресурсной группы с момента последнего запуска кластера (за исключением **Queueing queries**).

{% endlist %}


Также для просмотра доступна информация по ресурсным группам в разрезе хостов кластера {{ GP }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **Ресурсные группы по хостам**.
      
        На открывшейся странице будут отображены графики работы ресурсных групп по хостам.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:
 
    * **CPU Usage** — суммарная утилизация CPU в ресурсной группе в рамках хоста.
    * **Memory Usage** — суммарная утилизация памяти в ресурсной группе в рамках хоста.

{% endlist %}

## Интеграция с {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:
      * **{{ mgp-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mgp-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если показателей на графике больше одного, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для оповещения.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
