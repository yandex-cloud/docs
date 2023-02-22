* **Gp workfile compression**{#setting-gp-workfile-compression} {{ tag-con }} {{ tag-api }}

    Определяет, будут ли сжаты временные файлы, созданные на диске в процессе хеш-соединения или агрегации хеша.

    По умолчанию настройка выключена (временные файлы не сжимаются).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_workfile_compression).

* **Gp workfile limits per query**{#setting-gp-workfile-limits} {{ tag-con }} {{ tag-api }}

    Максимальный объем дискового пространства (в байтах), который могут занимать временные файлы активного запроса в каждом сегменте.

    Максимальное значение — `1099511627776` (1 ТБ), минимальное — `0` (объем не ограничен), по умолчанию — `0`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

* **Gp workfile limit files per query**{#setting-gp-workfile-limit-files} {{ tag-con }} {{ tag-api }}

    Максимальное количество временных файлов, которые сервис создает в сегменте для обработки одного запроса. Если этот предел превышен, запрос будет отменен.

    Максимальное значение — `100000`, минимальное — `0` (количество временных файлов не ограничено), по умолчанию — `10000`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

* **Gp workfile limit per segment**{#setting-gp-workfile-limit-per segment} {{ tag-con }} {{ tag-api }}

    Максимальный объем дискового пространства (в байтах), который могут занимать временные файлы всех активных запросов в каждом сегменте.

    Максимальное значение — `1099511627776` (1 ТБ), минимальное — `0` (объем не ограничен), по умолчанию — `0`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

* **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }}

    Фильтр команд SQL, которые будут записаны в лог {{ GP }}:

    * `NONE` — фильтр отключен, команды SQL не записываются в лог.
    * `DDL` — в лог записываются команды SQL, которые изменяют определения структур данных (`CREATE`, `ALTER`, `DROP` и т. п.).
    * `MOD` — в лог записываются команды SQL, попадающие под фильтр `DDL`, и команды, позволяющие изменять данные (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, и `COPY FROM`).
    * `ALL` — в лог записываются все команды SQL.

    Значение по умолчанию — `ALL`.

    Выражения `PREPARE` и `EXPLAIN ANALYZE` также записываются в лог, если содержат команды соответствующего типа.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#log_statement).

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }}

    Максимальное количество одновременных подключений к хосту-мастеру.

    Максимальное значение — `1000`, минимальное — `250`, по умолчанию — `350`. Для хостов-сегментов это значение автоматически умножается на пять.

    При увеличении значения этой настройки рекомендуется увеличить также [Max prepared transactions](#setting-max-prepared-transactions).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#max_connections).

* **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }}

    Максимальное количество транзакций, которые могут одновременно находиться в [подготовленном состоянии](https://www.postgresql.org/docs/9.6/sql-prepare-transaction.html).

    Максимальное значение — `10000`, минимальное — `350`, по умолчанию — `350`. Значения для хостов-мастеров и хостов-сегментов совпадают.

    Для настройки не рекомендуется выбирать значение ниже, чем у [Max connections](#setting-max-connections).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#max_prepared_transactions).

* **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }}

    Максимальный размер (в байтах) файлов лога [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write-Ahead Log) при репликации.

    Минимальное значение — `0` (лог не ведется), максимальное — `214748364800` (200 ГБ), по умолчанию — `0`.

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

* **Max statement mem**{#setting-max-statement-mem} {{ tag-con }} {{ tag-api }}

    Максимальный объем памяти (в байтах), выделяемый для обработки запроса.

    Минимальное значение — `134217728` (128 МБ), максимальное — `1099511627776` (1 ТБ), по умолчанию — `2097152000` (2000 МБ).

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#max_statement_mem).
