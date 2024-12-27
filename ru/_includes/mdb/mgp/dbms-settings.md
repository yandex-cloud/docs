* **Gp add column inherits table setting**{#setting-gp-add-column-inherits-table-setting} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Определяет, применяются ли параметры сжатия данных (`compresstype`, `compresslevel` и `blocksize`), указанные для [AOCO-таблицы](../../../managed-greenplum/concepts/tables.md), при добавлении столбца.

    По умолчанию настройка выключена (параметры сжатия данных, заданные для таблицы, не учитываются).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting).

* **Gp workfile compression**{#setting-gp-workfile-compression} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Определяет, будут ли сжаты временные файлы, созданные на диске в процессе хеш-соединения или агрегации хеша.

    По умолчанию настройка выключена (временные файлы не сжимаются).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression).

* **Gp workfile limits per query**{#setting-gp-workfile-limits} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальный объем дискового пространства (в байтах), который могут занимать временные файлы активного запроса в каждом сегменте.

    Максимальное значение — `1099511627776` (1 ТБ), минимальное — `0` (объем не ограничен), по умолчанию — `0`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

* **Gp workfile limit files per query**{#setting-gp-workfile-limit-files} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальное количество временных файлов, которые сервис создает в сегменте для обработки одного запроса. Если этот предел превышен, запрос будет отменен.

    Максимальное значение — `100000`, минимальное — `0` (количество временных файлов не ограничено), по умолчанию — `10000`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

* **Gp workfile limit per segment**{#setting-gp-workfile-limit-per-segment} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальный объем дискового пространства (в байтах), который могут занимать временные файлы всех активных запросов в каждом сегменте.

    Максимальное значение — `1099511627776` (1 ТБ), минимальное — `0` (объем не ограничен). Значение по умолчанию [зависит от размера хранилища хостов-сегментов](#settings-instance-dependent) и рассчитывается по формуле:

    ```text
    0.1 × <размер_хранилища_хоста-сегмента> / <количество_сегментов_на_хост>
    ```

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

* **Log connections**{#setting-log-connections} {{ tag-con }}

    Определяет, выводить ли в лог строку с подробным описанием каждого успешного подключения к серверу {{ GP }}.

    По умолчанию настройка выключена (логирование не ведется).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections).

* **Log disconnections**{#setting-log-disconnections} {{ tag-con }}

    Определяет, логировать ли завершение сессий. Если настройка включена, то при завершении клиентской сессии в лог выводится строка, в которой указывается продолжительность сессии.

    По умолчанию настройка выключена (логирование не ведется).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections).

* **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }}

    Задает уровень детализации информации в логе {{ GP }} для каждого сообщения. Уровни детализации лога в порядке увеличения информативности:

    * `terse`.
    * `default` (значение по умолчанию).
    * `verbose`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity).

* **Log hostname**{#setting-log-hostname} {{ tag-con }}

    Определяет, выводить ли в лог подключений имя хоста главного сервера базы данных {{ GP }}. Если настройка включена, то в лог выводятся IP-адрес и имя хоста. Если настройка выключена, то в лог выводится только IP-адрес.

    По умолчанию настройка выключена.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname).

* **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }}

    Задает минимальное время работы команды (в миллисекундах), при котором команда будет записана в лог.

    При значении `0` логируется время работы всех команд.

    Минимальное значение — `-1` (отключает логирование времени работы), максимальное значение — `2147483647`, по умолчанию — `-1`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement).

* **Log min messages**{#setting-log-min-messages} {{ tag-con }}

    Определяет уровень логирования {{ GP }}. Записываются все сообщения выбранного уровня важности и выше. Возможные значения (по возрастанию важности): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL` и `PANIC`.

    По умолчанию используется `WARNING`. Это означает, что в лог будут записаны все сообщения с уровнем важности `WARNING`, `ERROR`, `LOG`, `FATAL` и `PANIC`.

    Чтобы отключить запись большинства сообщений, выберите значение `PANIC`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages).

* **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Фильтр команд SQL, которые будут записаны в лог {{ GP }}:

    * `NONE` — фильтр отключен, команды SQL не записываются в лог.
    * `DDL` — в лог записываются команды SQL, которые изменяют определения структур данных (`CREATE`, `ALTER`, `DROP` и т. п.).
    * `MOD` — в лог записываются команды SQL, попадающие под фильтр `DDL`, и команды, позволяющие изменять данные (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, и `COPY FROM`).
    * `ALL` — в лог записываются все команды SQL.

    Значение по умолчанию — `DDL`.

    Выражения `PREPARE` и `EXPLAIN ANALYZE` также записываются в лог, если содержат команды соответствующего типа.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

* **Log statement stats**{#setting-log-statement-stat} {{ tag-con }}

    Определяет, выводить ли статистику по запросам (разбор, планирование, выполнение) в лог.

    По умолчанию настройка выключена (логирование не ведется).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats).

* **Master shared buffers**{#setting-master-shared-buffers} {{ tag-con }}

    Объем памяти, который хост-мастер {{ GP }} использует для буферов общей памяти (в байтах).

    Минимальное значение — `1048576` (1 МБ). Значение по умолчанию — `134217728` (128 МБ).

    Максимальное значение рассчитывается по формуле:

    ```text
    min(<размер_хранилища_хоста-мастера> / 4, 8 * <размер_данных_в_базе>)
    ```

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

    {% note warning %}

    Изменение этого параметра приведет к перезапуску кластера.

    {% endnote %}

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальное количество одновременных подключений к хосту-мастеру.

    Максимальное значение — `1000`, минимальное — `50`, по умолчанию — `350`. Для хостов-сегментов это значение автоматически умножается на пять.

    При увеличении значения этой настройки рекомендуется увеличить также [Max prepared transactions](#setting-max-prepared-transactions).

    При изменении настройки проводится проверка, что объем доступной оперативной памяти на одно подключение (как на мастере, так и на сегменте) будет составлять не меньше 20 МБ. Если это условие не выполняется, возникает [ошибка](../../../managed-greenplum/qa/cluster-hosts.md#memory-limit).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_connections).

* **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальное количество транзакций, которые могут одновременно находиться в [подготовленном состоянии]({{ pg.docs.org }}/current/sql-prepare-transaction.html).

    Максимальное значение — `10000`, минимальное — `350`, по умолчанию — `350`. Значения для хостов-мастеров и хостов-сегментов совпадают.

    Для настройки не рекомендуется выбирать значение ниже, чем у [Max connections](#setting-max-connections).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_prepared_transactions).

* **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальный размер (в байтах) файлов лога [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write-Ahead Log) при репликации.

    Минимальное значение — `0` (лог не ведется), максимальное — `214748364800` (200 ГБ). Значение по умолчанию [зависит от размера хранилища хостов-сегментов](#settings-instance-dependent) и рассчитывается по формуле:

    ```text
    0.1 × <размер_хранилища_хоста-сегмента> / <количество_сегментов_на_хост>
    ```

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

* **Max statement mem**{#setting-max-statement-mem} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Максимальный объем памяти (в байтах), выделяемый для обработки запроса.

    Минимальное значение — `134217728` (128 МБ), максимальное — `1099511627776` (1 ТБ), по умолчанию — `2097152000` (2000 МБ).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_statement_mem).

* **Segment shared buffers**{#setting-segment-shared-buffers} {{ tag-con }}

    Объем памяти, который хосты-сегменты {{ GP }} используют для буферов общей памяти (в байтах).

    Минимальное значение — `1048576` (1 МБ). Значение по умолчанию — `134217728` (128 МБ).

    Максимальное значение рассчитывается по формуле:

    ```text
    min(<размер_хранилища_хоста-сегмента> / (4 * <количество_сегментов_на_хост>), 8 * <размер_данных_в_базе>)
    ```

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

    {% note warning %}

    Изменение этого параметра приведет к перезапуску кластера.

    {% endnote %}
