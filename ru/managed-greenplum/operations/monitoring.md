---
title: Мониторинг состояния кластера {{ mgp-name }} и хостов
description: Следуя этой инструкции, вы сможете получить детальную информацию о состоянии кластера {{ mgp-name }} и провести диагностику.
---

# Мониторинг состояния кластера {{ mgp-name }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Принципы построения мониторинга

Для упрощения поиска проблем в консоль управления добавлены инструменты визуальной диагностики (дашборды), основанные на следующих принципах:

* **Иерархичность**: диагностика строится от общего к частному. Сначала вы видите агрегированные сигналы состояния всего кластера, а при обнаружении проблем можете углубиться в детали по конкретным компонентам (кластер, пулер, гибридное хранилище) или потребляемым ресурсам
* **Прагматичность**: вместо сотен графиков вам предлагаются только ключевые индикаторы. Особое внимание уделено **сигналам** — метрикам с четкими граничными значениями, которые сразу показывают наличие проблемы.
* **Автономность**: документация и дашборды спроектированы так, чтобы вы могли самостоятельно выявить причину деградации без обращения в поддержку.
* **Итеративность**: развитие инструментов диагностики ведется поэтапно на основе реального пользовательского опыта. Анализ поступивших запросов на улучшение инструментов позволяет сделать диагностику более точной и удобной.

## Система сигналов

В верхней части дашборда расположены сигналы, которые агрегируют состояние множества метрик. Они работают в режиме «светофора»:

| Статус | Значение | Описание |
| :--- | :--- | :--- |
| 🟢&nbsp;**OK** | `2` | Все важные индикаторы в норме. Кластер и компоненты работают штатно. |
| 🟠&nbsp;**Warn** | `1` | Обнаружены незначительные отклонения. Кластер работает, но требуется внимание для предотвращения ухудшения (например, рост очереди подключений или повышенная задержка). |
| 🔴&nbsp;**Crit** | `0` | Критическая деградация. Наблюдается нестабильная работа, недоступность компонентов или исчерпание ресурсов. Требуется немедленное вмешательство. |
| ⚪&nbsp;**Unknown** | `-1` | Данные отсутствуют или статус не определен. |

## Дашборд {{ ui-key.yacloud.mdb.cluster.label_mdb }} {#monitoring-cluster}

Основным инструментом диагностики является дашборд **Кластер**. Он предоставляет единую панель управления состоянием кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
      
        На открывшейся странице будет отображен дашборд с графиками и сигналами работы кластера {{ mgp-name }}.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    Дашборд состоит из следующих секций:

    *   **Сигналы**:
        *   **Cluster** — общий статус кластера.
        *   **Pooler** — статус пулера соединений.
        *   **Connections** — статус подключений.
        *   **Resources** — статус ресурсов хостов.
        *   **Queries** — статус выполнения тестовых запросов на чтение и запись.

    *   **Cluster**:
        *   **Read availability** — доступность кластера на чтение за последние 5 минут.
        *   **Write availability** — доступность кластера на запись за последние 5 минут.
        *   **Master switch history** — история переключений роли мастера (FQDN текущего мастера).
        *   **XID utilization** — процент использования [счетчика транзакций]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound).
        *   **Segments down** — количество сегментов в состоянии `down`.
        *   **Segments not in preferred role** — количество сегментов, не находящихся в предпочтительной роли.
        *   **Segments not synchronised** — количество несинхронизированных сегментов.
        *   **Log events** — количество событий в логах типов `WARNING`, `ERROR`, `FATAL`.

    *   **Pooler**:
        *   **Availability** — доступность пулера за последние 5 минут.
        *   **CPU usage** — утилизация CPU процессом пулера.
        *   **Memory usage** — потребление памяти процессом пулера.
        *   **Network usage** — объем отправленных и полученных данных.
        *   **Server connections** — количество активных и свободных серверных соединений.
        *   **Client connections** — количество активных клиентских соединений.
        *   **Query timings** — распределение длительности запросов по перцентилям.

    *   **Connections**:
        *   **Total master connections utilization** — общая утилизация подключений к мастеру.
        *   **Idle in transaction master connections utilization** — утилизация подключений, простаивающих в транзакции.
        *   **Master connections** — детализация подключений к мастеру по состояниям: `active`, `idle`, `idle in transaction`, `waiting`, `aborted`, суммарное число по всем состояниям `total` и ограничение `max`.
        *   **Total segments connections utilization** — утилизация подключений по сегментам.

    *   **Resources**:
        * Секция разделена на подгруппы **Master hosts** и **Segment hosts**.
        *   **Load Average** — средняя нагрузка за 15 минут.
        *   **CPU utilization** — утилизация процессора.
        *   **Virtual memory consumption** — потребление виртуальной памяти.
        *   **Physical memory consumption** — потребление физической памяти.
        *   **Network packets** — количество отправленных и полученных пакетов в секунду.
        *   **Network packets in queues** — количество пакетов в очередях сетевого интерфейса.
        *   **Network traffic** — объем отправленного и полученного трафика.
        *   **Disk space utilization** — процент занятого дискового пространства.
        *   **Disk IO** — объем чтения и записи с диска в байтах в секунду.
        *   **Interconnect retransmits ratio** (только для сегментов) — отношение переотправленных пакетов межсегментного взаимодействия к общему числу отправленных.

    *   **Queries**:
        *   **Read test query duration** — время выполнения тестового запроса на чтение.
        *   **Write test query duration** — время выполнения тестового запроса на запись.
        *   **Read duration from each segment** — время выполнения тестового запроса на чтение в разрезе сегментов.
        *   **Queries sent to the cluster** — количество новых и завершенных с ошибкой запросов.
        *   **Queries execution time distribution** — гистограмма длительности завершенных запросов.
        *   **Running queries execution time distribution** — гистограмма распределения длительности выполнения запросов.
        *   **Spill files count** — количество временных файлов (всего и по хостам).
        *   **Spill files size** — размер временных файлов (всего и по хостам).

    *   **Resource groups**:
        * Графики в данной секции отображают информацию в разрезе по группам процессов:
            * **admin_group** — в административной группе;
            * **default_group** — в группе по умолчанию.
        *   **Connections utilization by resource group** — утилизация подключений.
        *   **CPU usage by resource group** — потребление CPU.
        *   **Memory utilization by resource group** — процент утилизации памяти:
        *   **Memory usage by resource group** — абсолютное значение использованной и доступной памяти.
        *   **Running transactions by resource group** — количество выполняемых транзакций.
        *   **Executed transactions by resource group** — частота транзакций.
        *   **Queueing transactions by resource group** — количество транзакций в очереди.

    *   **Background activities**:
        *   **Vacuum: catalog**:
            *   **Catalog size** — размер системного каталога в разрезе по базам данных.
            *   **Catalog percent of dead tuples** — процент «мертвых» кортежей в каталоге в разрезе по базам данных.
        *   **Vacuum: pg_attribute**:
            *   **pg_attribute size** — размер таблицы `pg_attribute` в разрезе по базам данных.
            *   **pg_attribute percent of dead tuples** — процент «мертвых» кортежей в таблице `pg_attribute` в разрезе по базам данных.
        *   **Vacuum/analyze: user tables**:
            *   **Tables vacuum age** — распределение таблиц по числу дней с момента последнего выполнения [очистки](../concepts/maintenance.md#custom-table-vacuum) (`VACUUM`).
            *   **Tables analyze age** — распределение таблиц по числу дней с момента последнего [сбора статистики](../concepts/maintenance.md#get-statistics) (`ANALYZE`).
    *   **Hybrid storage**:
        *   **CPU usage per host** — потребление CPU компонентом `yproxy` в разрезе по хостам кластера.
        *   **Memory usage per host** — потребление памяти компонентом `yproxy` в разрезе по хостам кластера.
        *   **Storage requests** — количество запросов к хранилищу (всего, успешных, с ошибками).
        *   **Storage objects count** — общее количество объектов в хранилище.
        *   **Storage objects size** — суммарный размер объектов в хранилище.

{% endlist %}

## Дашборд {{ ui-key.yacloud.mdb.cluster.switch_hosts }} {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mgp-name }} используется дашборд **Хосты**. В верхней части дашборда расположены сигналы состояния ресурсов (CPU, Memory, Disk), ниже — детальные графики по категориям.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
    1. Выберите нужный хост.

        На открывшейся странице будут отображены графики состояния конкретного хоста кластера.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    Дашборд состоит из следующих секций:

    *   **Сигналы**:
        *   **CPU** — нагрузка на процессор.
        *   **Memory** — использование и доступность виртуальной памяти.
        *   **Disk** — заполненность диска данных.
    *   **CPU**:
        *   **Load average 15 min** — средняя нагрузка на процессор за 15 минут.
        *   **Load average 5 min** — средняя нагрузка на процессор за 5 минут.
        *   **Load average 1 min** — средняя нагрузка на процессор за 1 минуту.
        *   **CPU utilization** — процент загрузки процессорных ядер.
        *   **CPU pressure time** — время в микросекундах, в течение которого процессы ожидали доступа к процессору.
        *   **CPU** — распределение времени процессора по различным состояниям (`user`, `system`, `idle`, `iowait` и другие).
        *   **Process statuses** — количество процессов в различных состояниях: `running`, `idle`, `interruptible sleep`, `uninterruptible sleep`, `zombie`.
    *   **Memory**:
        *   **Virtual memory utilization** — процент использования виртуальной памяти.
        *   **Virtual memory usage** — объем использованной виртуальной памяти в байтах.
        *   **Out of memory count** — количество событий нехватки памяти.
        *   **Memory utilization** — процент использования физической оперативной памяти.
        *   **Memory usage** — объем использованной физической памяти в байтах.
        *   **Memory pressure time** — время, в течение которого процессы ожидали доступа к памяти.

    *   **Disk**:
        *   **Disk usage percent** — процент занятого места на диске данных.
        *   **Disk usage** — объем занятых данных на диске в байтах.
        *   **Disk read/write operations** — количество операций чтения и записи в секунду.
        *   **Disk read/write bytes** — объем данных в байтах, прочитанных и записанных за секунду.
        *   **Disk read and write time** — среднее время выполнения операций чтения и записи.
    *   **Disk Metrics Details**:
        *   **Disk read latency (percentiles)** — распределение времени операций чтения с диска по процентилям.
        *   **Disk write latency (percentiles)** — распределение времени операций записи на диск по процентилям.
        *   **Disk read throttler latency (percentiles)** — распределение задержек операций чтения с диска, вносимых механизмом ограничения при превышении квоты, по процентилям.
        *   **Disk write throttler latency (percentiles)** — распределение задержек операций записи на диск, вносимых механизмом ограничения при превышении квоты, по процентилям.
        *   **Disk read operations** — среднее и максимальное количество операций чтения с диска в секунду.
        *   **Disk write operations** — среднее и максимальное количество операций записи на диск в секунду.
        *   **Disk used quota** — процент использования квоты на дисковые операции.
        *   **Disk read bytes** — среднее и максимальное количество прочитанных байт с диска.
        *   **Disk write bytes** — среднее и максимальное количество записанных байт на диск.

    *   **Network**:
        *   **Client network reliability** — индикатор надежности сетевого интерфейса.
        *   **Client network packets sent** — количество отправленных пакетов в секунду на интерфейсе.
        *   **Client network packets received** — количество полученных пакетов в секунду на интерфейсе.
        *   **Client network errors** — количество ошибок при отправке и получении пакетов.
        *   **Client network drops** — количество отброшенных пакетов.
        *   **Client network interface errors/drops** — детализация ошибок и потерь по интерфейсу.
        *   **Client network bytes** — объем трафика (байт в секунду) на интерфейсе.

{% endlist %}

## Дашборд {{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }} {#monitoring-pxf}

Для просмотра детальной информации о состоянии [PXF](external-tables.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** → **{{ ui-key.yacloud.greenplum.cluster.pxf.value_pxf }}**.

        На открывшейся странице будут отображены графики состояния PXF.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Сигналы**:
        * **Availability** — доступность сервиса PXF за последние 5 минут.
        * **Memory Utilization** — индикатор использования памяти сервисом PXF.
        * **CPU Utilization** — индикатор использования CPU сервисом PXF.

    * **Overview** — общие показатели сервиса PXF:
        * **Unavailable instances** — недоступные инстансы PXF.
        * **Max Memory Usage** — максимальное использование памяти среди всех инстансов PXF.
        * **Total OOM Events** — суммарное число событий нехватки памяти на всех инстансах PXF за период.
        * **Max CPU Usage** — максимальное использование CPU среди всех инстансов PXF.
        * **Max PXF Threads Usage** — максимальное число занятых и запущенных потоков сервиса PXF среди всех инстансов.
        * **Total Log Events By Level** — суммарное число событий в логах уровней `warn`, `error` и `fatal` на всех инстансах PXF.
        * **Total Sent And Received Data** — суммарный объем данных в секунду, отправленных из источников данных PXF в базе данных и полученных источниками из базы данных.
        * **Total Sent And Received Records** — суммарное число записей в секунду, отправленных из источников данных PXF в базе данных и полученных источниками из базы данных.
        * **Total Read And Write Requests** — суммарное число запросов в секунду на чтение базой данных из источника данных и на запись в источник данных из базы данных.
        * **Max Read And Write Requests Latency** — максимальная задержка запросов на чтение и запись.

    * **By host statistics** — показатели в разрезе хостов:
        * **Top 10 Hosts By Memory Usage** — топ-10 хостов по использованию памяти сервисом PXF.
        * **OOM Events By Hosts** — число событий нехватки памяти на каждом инстансе PXF за период.
        * **Top 10 Hosts By CPU Usage** — топ-10 хостов по использованию CPU сервисом PXF.
        * **Top 10 Hosts By PXF Current Threads Usage** — топ-10 инстансов PXF по числу запущенных потоков.
        * **Top 10 Hosts By Busy PXF Threads Usage** — топ-10 инстансов PXF по числу занятых потоков.
        * **Top 10 Hosts By Fatal Log Events** — топ-10 хостов по числу событий уровня `fatal` в логах PXF.
        * **Top 10 Hosts By Error Log Events** — топ-10 хостов по числу событий уровня `error` в логах PXF.
        * **Top 10 Hosts By Warn Log Events** — топ-10 хостов по числу событий уровня `warn` в логах PXF.
        * **Top 10 Hosts By Sent Data** — топ-10 хостов по объему данных, отправленных из источников данных PXF в базу данных в секунду.
        * **Top 10 Hosts By Received Data** — топ-10 хостов по объему данных, полученных источниками данных PXF из базы данных в секунду.
        * **Top 10 Hosts By Sent Records** — топ-10 хостов по числу записей, отправленных из источника данных PXF в базу данных в секунду.
        * **Top 10 Hosts By Received Records** — топ-10 хостов по числу записей, полученных источниками данных PXF из базы данных в секунду.
        * **Top 10 Hosts By Read Requests** — топ-10 хостов по числу запросов на чтение базой данных из источника данных PXF в секунду.
        * **Top 10 Hosts By Write Requests** — топ-10 хостов по числу запросов на запись в источник данных PXF из базы данных в секунду.
        * **Top 10 Hosts By Read Requests Latency** — топ-10 хостов по задержке запросов на чтение базой данных из источника данных PXF.
        * **Top 10 Hosts By Write Requests Latency** — топ-10 хостов по задержке запросов на запись в источник данных PXF из базы данных.

    * **By server statistics** — показатели в разрезе источников данных PXF:
        * **Top 10 Servers By Sent Data** — топ-10 источников данных PXF по объему данных, отправленных в базу данных в секунду.
        * **Top 10 Servers By Received Data** — топ-10 источников данных PXF по объему данных, полученных из базы данных в секунду.
        * **Top 10 Servers By Sent Records** — топ-10 источников данных PXF по числу записей, отправленных в базу данных в секунду.
        * **Top 10 Servers By Received Records** — топ-10 источников данных PXF по числу записей, полученных из базы данных в секунду.
        * **Top 10 Servers By Read Requests** — топ-10 источников данных PXF по числу запросов на чтение из базы данных в секунду.
        * **Top 10 Servers By Write Requests** — топ-10 источников данных PXF по числу запросов на запись в базу данных в секунду.
        * **Top 10 Servers By Read Requests Latency** — топ-10 источников данных PXF по задержке запросов на чтение из базы данных.
        * **Top 10 Servers By Write Requests Latency** — топ-10 источников данных PXF по задержке запросов на запись в базу данных.

    * **By user statistics** — показатели в разрезе пользователей:
        * **Top 10 Users By Sent Data** — топ-10 пользователей по объему данных, отправленных из источников данных PXF в базу данных в секунду.
        * **Top 10 Users By Received Data** — топ-10 пользователей по объему данных, полученных источниками данных PXF из базы данных в секунду.
        * **Top 10 Users By Sent Records** — топ-10 пользователей по числу записей, отправленных из источника данных PXF в базу данных в секунду.
        * **Top 10 Users By Received Records** — топ-10 пользователей по числу записей, полученных источниками данных PXF из базы данных в секунду.
        * **Top 10 Users By Read Requests** — топ-10 пользователей по числу запросов на чтение базой данных из источника данных PXF в секунду.
        * **Top 10 Users By Write Requests** — топ-10 пользователей по числу запросов на запись в источник данных PXF из базы данных в секунду.
        * **Top 10 Users By Read Requests Latency** — топ-10 пользователей по задержке запросов на чтение базой данных из источника данных PXF.
        * **Top 10 Users By Write Requests Latency** — топ-10 пользователей по задержке запросов на запись в источник данных PXF из базы данных.

{% endlist %}


## Мониторинг ресурсных групп {#monitoring-resgroup}

Для просмотра информации по ресурсным группам {{ mgp-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
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


Также для просмотра доступна информация по ресурсным группам в разрезе хостов кластера {{ mgp-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
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
  1. Перейдите в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:
      * **{{ mgp-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mgp-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если показателей на графике больше одного, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов читайте в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для оповещения.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Для сигналов рекомендуется устанавливать алерты на переход в статус `Crit` (значение `0`) или `Warn` (значение `1`).

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик приведен в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}).
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
