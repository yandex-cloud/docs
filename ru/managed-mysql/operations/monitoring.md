---
title: "Мониторинг состояния кластера MySQL и хостов"
description: "Вы можете отслеживать состояние кластера {{ mmy-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков."
---

# Мониторинг состояния {{ MY }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mmy-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На вкладке отображаются графики:

* **Average query time** — среднее время исполнения запросов, для каждого хоста (в миллисекундах).
* **Connections** — количество подключений, для каждого хоста.
* **Disk usage** — занятое дисковое пространство (в байтах), для каждого хоста и для кластера в целом.
* **Is Alive, [boolean]** — показывает доступность кластера в виде суммы состояний его хостов.

    Каждый хост в состоянии **Alive** увеличивает общую доступность на 1. При выходе из строя одного из хостов общая доступность уменьшается на 1.

    Для повышения доступности кластера вы можете [добавить в него хосты](hosts.md#add).

* **Is Primary, [boolean]** — показывает, какой хост является мастером и как долго.
* **Free space** — свободное дисковое пространство для каждого хоста (в байтах).
* **Queries per second** — общее количество запросов в секунду, для каждого хоста.
* **Replication lag** — отставание реплики от мастера (в секундах).
* **Slow queries per second** — количество SQL-запросов в секунду, выполняющихся дольше, чем указано в [параметре](../concepts/settings-list.md#setting-long-query-time) `long_query_time`, для каждого хоста.
* **Threads running** — количество запущенных потоков, для каждого хоста. При увеличении нагрузки на кластер это значение будет быстро расти.

В блоке **Master overview** отображаются расширенные сведения о мастере:

* **Disk usage** — детализация занятого дискового пространства (в байтах):
   * **data** — объем, занятый данными.
   * **default tablespace** — объем, занятый данными в табличном пространстве по умолчанию.
   * **innodb logs** — объем, занятый логами InnoDB.
   * **relaylogs**, **binlogs** — объем, занятый служебными логами {{ MY }}. Подробнее [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) и [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html) описаны в документации {{ MY }}.
   * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
   * **undo tablespace** — объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **InnoDB locks** — количество блокировок таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB rows operations** — число операций со строками таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Query quantiles** — квантили среднего времени выполнения запроса.
* **Sorts and joins** — доли операций сортировки и объединения в общем числе операций. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Table cache** — характеристики кешированных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Temp tables** — количество временных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Thread states** — количество потоков, запущенных демоном `mysqld`, в определенном состоянии. Описание состояний см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Threads** — количество потоков, запущенных демоном `mysqld`.
   * **Threads cached** — количество кешированных потоков.

      При нормальной работе кластера процесс `mysqld` кеширует большую часть соединений.

   * **Threads connected** — количество открытых потоков.

       Приближение графика к максимальному значению может означать, что открытые соединения не закрываются.

       Максимальное значение задает [параметр](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   * **Threads running** — количество запущенных потоков.

       При увеличении нагрузки на кластер это значение будет быстро расти.

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mmy-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{mmy-name }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
1. Перейдите на страницу **Мониторинги**.
1. Выберите нужный хост из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **idle** уменьшается.
* **Disk read/write bytes** — скорость дисковых операций (байт/с).
* **Disk IOPS** — интенсивность дисковых операций (операций/с).

    На графиках **Disk read/write bytes** и **Disk IOPS** показатель **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение показателя **Free** уменьшается, остальные — растут.
* **Network Bytes** — скорость обмена данными по сети (байт/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

   Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.

В блоке **MySQL overview** отображаются расширенные сведения о состоянии СУБД на хосте:

* **Disk usage** — детализация занятого дискового пространства (в байтах):
   * **data** — объем, занятый данными.
   * **default tablespace** — объем, занятый данными в табличном пространстве по умолчанию.
   * **innodb logs** — объем, занятый логами InnoDB.
   * **relaylogs**, **binlogs**  — объем, занятый служебными логами {{ MY }}. Подробнее [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) и [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html) описаны в документации {{ MY }}.
   * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
   * **undo tablespace** — объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **Inode usage** — использованное количество inodes.
* **File IO read bytes** — скорость чтения данных (байт/с).
* **File IO read operations** — средняя скорость файловых операций чтения (в секунду). Описание операций см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **File IO write bytes** — скорость записи данных (байт/с).
* **File IO write operations** — средняя скорость файловых операций записи (в секунду). Описание операций см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Handlers** — количество обработчиков различных операций. Подробнее см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB cache efficiency** — характеристики эффективности буфера InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB data operations** — количество операций InnoDB:
   * **innodb data fsyncs** — операции `fsync()` при сбросе данных на диск;
   * **innodb data reads** — операции чтения с диска;
   * **innodb data writes** — операции записи.
* **InnoDB lock time** — время ожидания блокировки таблиц InnoDB (в секундах).
* **InnoDB locks** — количество блокировок таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB rows operation** — число операций со строками таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Queries per second** — общее количество запросов в секунду.
* **Query quantiles** — квантили среднего времени выполнения запроса.
* **Replication lag** — отставание реплики от мастера (в секундах).
* **SemiSync latency** — детализация задержки подтверждения транзакции при [полусинхронной репликации](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html) (в секундах). Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Slow queries per second** — количество SQL-запросов в секунду, выполняющихся дольше, чем указано в [параметре](../concepts/settings-list.md#setting-long-query-time) `long_query_time`.
* **Sorts and joins** — доли операций сортировки и объединения в общем числе операций. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Table cache** — характеристики кешированных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Temp tables** — количество временных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Thread states** — количество потоков, запущенных демоном `mysqld`, в определенном состоянии. Описание состояний см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Threads** — количество потоков, запущенных демоном `mysqld`.
   * **Threads cached** — количество кешированных потоков.

      При нормальной работе хоста процесс `mysqld` кеширует большую часть соединений.
   * **Threads connected** — количество открытых потоков.

       Приближение графика к максимальному значению может означать, что открытые соединения не закрываются.

       Максимальное значение задает [параметр](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   * **Threads running** — количество запущенных потоков.

       При увеличении нагрузки на хост это значение будет быстро расти.

{% if audience != "internal" %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.

    1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.

    1. В блоке **Сервисные дашборды** выберите:

        * **{{ mmy-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mmy-name }} — Host Overview** для настройки алертов хостов.

    1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.

    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).

    1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.

    1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                             | Обозначение               | `Alarm`                   | `Warning`                 |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Задержка репликации                 | `mysql_replication_lag`   | `600`                     | `60`                      |
| Количество работоспособных хостов   | `mysql_is_alive`          | `<количество хостов> - 2` | `<количество хостов> - 1` |
| Среднее время выполнения запросов   | `mysql_latency_query_avg` | —                         | `2000`                    |
| Размер использованного хранилища    | `disk.used_bytes`         | 90% от размера хранилища  | 80% от размера хранилища  |
| Утилизация CPU                      | `cpu.idle`                | `10`                      | `20`                      |

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-mysql).

{% endif %}

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **{{ mmy-name }}**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mmy-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-mysql`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `replica`

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

{% cut "Метрики сервиса" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk-used_bytes_mysql_binlogs`<br/>`DGAUGE`, байты | Объем, занятый служебными логами MySQL. | 
| `disk-used_bytes_mysql_data`<br/>`DGAUGE`, байты | Объем, занятый данными. | 
| `disk-used_bytes_mysql_default_tablespace`<br/>`DGAUGE`, байты | Объем, занятый данными в табличном пространстве по умолчанию. | 
| `disk-used_bytes_mysql_innodb_logs`<br/>`DGAUGE`, байты | Объем, занятый логами InnoDB. | 
| `disk-used_bytes_mysql_relaylogs`<br/>`DGAUGE`, байты | Объем, занятый служебными логами MySQL. | 
| `disk-used_bytes_mysql_temp_tablespace`<br/>`DGAUGE`, байты | Объем, занятый данными во временном табличном пространстве. | 
| `disk-used_bytes_mysql_undo_tablespace`<br/>`DGAUGE`, байты | Объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html). | 
| `mysql_Aborted_connects_rate`<br/>`DGAUGE`, соединений/с | Количество неуспешных попыток соединения с БД. | 
| `mysql_Binlog_cache_disk_use_rate`<br/>`DGAUGE`, транзакций/с | Количество транзакций, которые использовали кеш бинлога, но превысили его размер и задействовали временный файл на диске. | 
| `mysql_Binlog_cache_use_rate`<br/>`DGAUGE`, транзакций/с | Количество транзакций, которые использовали кеш бинлога. | 
| `mysql_Connections_rate`<br/>`DGAUGE`, соединений/с | Количество попыток соединения с БД (успешных и неуспешных). | 
| `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество временных таблиц, созданных на диске при обработке запросов БД. | 
| `mysql_Created_tmp_files_rate`<br/>`DGAUGE`, файлов/с | Количество временных файлов БД. | 
| `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество временных таблиц, созданных при обработке запросов БД. | 
| `mysql_Fileio_read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения данных.<br/>Дополнительные метки: `filetype` | 
| `mysql_Fileio_reads`<br/>`DGAUGE`, операций/с | Средняя скорость файловых операций чтения (в секунду).<br/>Дополнительные метки: `filetype` | 
| `mysql_Fileio_write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи данных.<br/>Дополнительные метки: `filetype` | 
| `mysql_Fileio_writes`<br/>`DGAUGE`, операций/с | Средняя скорость файловых операций записи (в секунду).<br/>Дополнительные метки: `filetype` | 
| `mysql_Handler_<handler>.*_rate`<br/>`DGAUGE`, штуки | Количество обработчиков различных операций. Подробнее см. в [документации MySQL](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html). <br/>Дополнительные метки: `handler` | 
| `mysql_Innodb_buffer_pool_pages_data`<br/>`DGAUGE`, штуки | Количество страниц с данными в буфере InnoDB. Включает `dirty` и `clean`. | 
| `mysql_Innodb_buffer_pool_pages_dirty`<br/>`DGAUGE`, штуки | Количество `dirty` страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_free`<br/>`DGAUGE`, штуки | Количество свободных страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_misc`<br/>`DGAUGE`, штуки | Количество служебных страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_total`<br/>`DGAUGE`, штуки | Количество страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_read_requests_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения InnoDB. | 
| `mysql_Innodb_buffer_pool_reads_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения InnoDB, для обработки которых InnoDB вынуждена обращаться к диску. | 
| `mysql_Innodb_checkpoint_age`<br/>`DGAUGE`, байты | Размер данных в памяти InnoDB до сброса на диск. | 
| `mysql_Innodb_checkpoint_max_age`<br/>`DGAUGE`, байты | Предельный размер данных в памяти InnoDB до сброса на диск. | 
| `mysql_Innodb_data_fsyncs_rate`<br/>`DGAUGE`, операций/с | Количество операций _fsync()_ при сбросе данных на диск в InnoDB. | 
| `mysql_Innodb_data_reads_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения с диска в InnoDB. | 
| `mysql_Innodb_data_writes_rate`<br/>`DGAUGE`, операций/с | Количество записи в InnoDB. | 
| `mysql_Innodb_page_size`<br/>`DGAUGE`, байты | Размер страницы в InnoDB (по умолчанию 16KB). | 
| `mysql_Innodb_row_lock_current_waits`<br/>`DGAUGE`, штуки | Количество блокировок строк в InnoDB. | 
| `mysql_Innodb_row_lock_time_rate`<br/>`DGAUGE`, миллисекунды | Общее время ожидания блокировки строк в InnoDB. | 
| `mysql_Innodb_row_lock_waits_rate`<br/>`DGAUGE`, операций/с | Количество операций InnoDB, которым пришлось ждать блокировки строк. | 
| `mysql_Innodb_rows_deleted_rate`<br/>`DGAUGE`, строк/с | Количество удаленных строк в InnoDB. | 
| `mysql_Innodb_rows_inserted_rate`<br/>`DGAUGE`, строк/с | Количество добавленных строк в InnoDB. | 
| `mysql_Innodb_rows_read_rate`<br/>`DGAUGE`, строк/с | Количество строк, считанных из таблиц InnoDB. | 
| `mysql_Innodb_rows_updated_rate`<br/>`DGAUGE`, строк/с | Количество обновленных строк в InnoDB. | 
| `mysql_Open_table_definitions`<br/>`DGAUGE`, штуки | Количество кешируемых определений таблиц. | 
| `mysql_Open_tables`<br/>`DGAUGE`, штуки | Количество открытых таблиц.  | 
| `mysql_Opened_table_definitions_rate`<br/>`DGAUGE`, таблиц/с | Количество кешируемых определений таблиц в единицу времени. | 
| `mysql_Opened_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество открытых таблиц в единицу времени. | 
| `mysql_Prepared_stmt_count`<br/>`DGAUGE`, штуки | Количество подготовленных выражений. | 
| `mysql_Queries_rate`<br/>`DGAUGE`, запросы/с | Количество выполняемых запросов, включая запросы пользователей и хранимые процедуры, в единицу времени. | 
| `mysql_Questions_rate`<br/>`DGAUGE`, запросы/с | Количество выполняемых запросов от пользователей в единицу времени. | 
| `mysql_Rpl_semi_sync_master_clients`<br/>`DGAUGE`, штуки | Количество полусинхронных реплик. | 
| `mysql_Rpl_semi_sync_master_tx_avg_wait_time`<br/>`DGAUGE`, микросекунды | Среднее время ожидания транзакции источником репликации. | 
| `mysql_Rpl_semi_sync_master_tx_wait_time_rate`<br/>`DGAUGE`, микросекунды | Суммарное время ожидания транзакции источником репликации за единицу времени. | 
| `mysql_Rpl_semi_sync_master_wait_sessions`<br/>`DGAUGE`, штуки | Количество сессий, ожидающих ответа от реплик. | 
| `mysql_Select_full_join_rate`<br/>`DGAUGE`, запросы/с | Количество джоинов, которые используют скан таблицы вместо индекса. | 
| `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, запросы/с | Количество джоинов, которые используют поиск по интервалу в референсной таблице. | 
| `mysql_Session_<stage>.*`<br/>`DGAUGE`, штуки | Количество сессий на определенной стадии. <br/>Дополнительные метки: `stage` | 
| `mysql_Slow_queries_rate`<br/>`DGAUGE`, запросы/с | Количество медленных запросов, которые выполняются дольше `long_query_time` секунд, в единицу времени. | 
| `mysql_Sort_range_rate`<br/>`DGAUGE`, запросы/с | Количество сортировок по интервалам в единицу времени. | 
| `mysql_Sort_rows_rate`<br/>`DGAUGE`, запросы/с | Количество отсортированных строк в единицу времени. | 
| `mysql_Sort_scan_rate`<br/>`DGAUGE`, запросы/с | Количество сортировок с использованием скана таблицы в единицу времени. | 
| `mysql_Table_locks_immediate`<br/>`DGAUGE`, штуки | Количество немедленных блокировок таблиц. | 
| `mysql_Table_locks_waited`<br/>`DGAUGE`, штуки | Количество блокировок таблиц, которым пришлось ждать.  | 
| `mysql_Table_open_cache_hits_rate`<br/>`DGAUGE`, операций/с | Количество хитов для поисков в кеше открытых таблиц в единицу времени. | 
| `mysql_Table_open_cache_misses_rate`<br/>`DGAUGE`, операций/с | Количество неуспешных ппопыток поиска в кеше открытых таблиц в единицу времени. | 
| `mysql_Threads_cached`<br/>`DGAUGE`, штуки | Количество потоков, которые находятся в кеше. | 
| `mysql_Threads_connected`<br/>`DGAUGE`, штуки | Количество потоков, которые обрабатывают открытые подключения к БД. | 
| `mysql_Threads_created_rate`<br/>`DGAUGE`, потоки/с | Количество создаваемых потоков в единицу времени. | 
| `mysql_Threads_running`<br/>`DGAUGE`, штуки | Количество потоков, которые запущены в данный момент. | 
| `mysql_config_innodb_buffer_pool_size`<br/>`DGAUGE`, байты | Размер буферного пула InnoDB. | 
| `mysql_config_innodb_log_file_size`<br/>`DGAUGE`, байты | Размер лог файла в лог группе.  | 
| `mysql_config_max_connections`<br/>`DGAUGE`, штуки | Максимальное количество параллельных подключений.  | 
| `mysql_config_table_open_cache`<br/>`DGAUGE`, штуки | Количество открытых таблиц для всех потоков. | 
| `mysql_config_thread_cache_size`<br/>`DGAUGE`,число | Количество потоков, которые нужно кешировать для повторного использования. | 
| `mysql_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `mysql_is_primary`<br/>`DGAUGE`, 0/1 | Показатель хоста-мастера.<br/>Принимает значение `1`, если хост БД является мастером, `0`, если нет. | 
| `mysql_is_replica`<br/>`DGAUGE`, 0/1 | Показатель хоста-реплики.<br/>Принимает значение `1`, если хост БД является репликой, `0`, если нет.  | 
| `mysql_latency_query_0.5`<br/>`DGAUGE`, cекунды | Время выполнения запросов, медиана. | 
| `mysql_latency_query_0.75`<br/>`DGAUGE`, cекунды | Время выполнения запросов, 0.75 процентиль. | 
| `mysql_latency_query_0.90`<br/>`DGAUGE`, cекунды | Время выполнения запросов, 0.90 процентиль. | 
| `mysql_latency_query_0.95`<br/>`DGAUGE`, cекунды | Время выполнения запросов, 0.95 процентиль. | 
| `mysql_latency_query_0.99`<br/>`DGAUGE`, cекунды | Время выполнения запросов, 0.99 процентиль. | 
| `mysql_latency_query_avg`<br/>`DGAUGE`, cекунды | Среднее время выполнения запросов. | 
| `mysql_replication_lag`<br/>`DGAUGE`, cекунды | Отставание реплики от мастера. | 

{% endcut %}

{% cut "Прочие метрики" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет.  | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет.  | 

{% endcut %}

{% endif %}
