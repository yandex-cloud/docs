- **Audit log**{#setting-audit-log} {{ tag-all }}

  Управляет записью лога аудита {{ MY }}.

  По умолчанию запись лога аудита выключена.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables).

- **Auto increment**{#setting-auto-increment-increment} {{ tag-all }}

  Задает интервал между значениями столбцов с атрибутом `AUTO_INCREMENT`.

  Минимальное значение — `1`, максимальное значение — `65535`, по умолчанию — `1`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment).

- **Auto increment offset**{#setting-auto-increment-offset} {{ tag-all }}

  Задает начальное значение для столбцов с атрибутом `AUTO_INCREMENT`. Эта настройка игнорируется, если ее значение больше значения настройки [Auto increment](#setting-auto-increment-increment).

  Минимальное значение — `1`, максимальное значение — `65535`, по умолчанию — `1`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset).

- **Binlog cache size**{#setting-binlog-cache-size} {{ tag-all }}

  Размер кеша (в байтах) для хранения изменений [бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html) во время транзакции.

  Минимальное значение — `4096` (4 КБ), максимальное значение — `67108864` (64 МБ), по умолчанию — `32768` (32 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size).

- **Binlog group commit sync delay**{#setting-binlog-sync-delay} {{ tag-all }}

  Задержка перед синхронизацией бинарного лога с диском при операции `COMMIT` для бинарного лога. Чтобы синхронизировать с диском больше транзакций за раз, задайте задержку больше нуля. Это снизит общее время, затрачиваемое на операцию `COMMIT` для группы транзакций.

  Минимальное значение — `0` (нет задержки), максимальное значение — `1000000` (одна секунда), по умолчанию — `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay).

- **Binlog row image**{#setting-binlog-row-image} {{ tag-all }}

  Способ записи образов строк (row images) в бинарный лог при построчной репликации (row-based replication):
  - `FULL` (по умолчанию) — все столбцы записываются как в образ «до», так и в образ «после»;
  - `MINIMAL` — в образ «до» записываются только столбцы, требуемые для идентификации строк, которые нужно изменить; в образ «после» записываются только столбцы, для которых было задано значение с помощью SQL-выражения или операции автоинкремента.
  - `NOBLOB` — все столбцы записываются в образы «до» и «после» (как в способе `FULL`), за исключением столбцов `BLOB` и `TEXT`, которые либо не изменились, либо не требуются для идентификации строк.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image).

- **Binlog rows query log events**{#setting-binlog-log-events} {{ tag-all }}

  Управляет записью информационных событий (например, событий лога запросов) в бинарный лог.

  По умолчанию запись событий в бинарный лог выключена.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events).

- **Binlog transaction dependency tracking**{#setting-binlog-transaction-dependency-tracking} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Схема для вычисления логических временных меток, с помощью которых реплики определяют, какие транзакции могут выполняться параллельно. Используется при генерации информации о зависимостях, которая записывается в бинарный лог при включенной многопоточной репликации ([Slave parallel workers](#setting-slave-parallel-workers)) с политикой [Slave parallel type](#setting-slave-parallel-type) `LOGICAL_CLOCK`.

  Доступные значения:

  - `COMMIT_ORDER` (по умолчанию) — две транзакции считаются независимыми, если интервал времени фиксации первой транзакции пересекается с интервалом времени фиксации второй транзакции.
  - `WRITESET` — схема основана на `COMMIT_ORDER`. Дополнительно к ней две транзакции считаются конфликтующими, если есть некоторое число (хэш), которое встречается в наборах записи обеих транзакций.
  - `WRITESET_SESSION` — две транзакции считаются зависимыми, если выполняется хотя бы одно из условий:

    - Транзакции зависимы в соответствии со схемой `WRITESET`.
    - Транзакции были зафиксированы в одном сеансе пользователя.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- **Character set server**{#setting-character-set-server} {{ tag-all }}

  [Кодировка](https://dev.mysql.com/doc/refman/8.0/en/charset.html), которую кластер {{ MY }} использует при работе с данными и обмене информацией с клиентами {{ MY }}. Выбор кодировки влияет на работу SQL-функций для манипуляций со строками и другие возможности.

  По умолчанию: `utf8mb4`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server).

- **Collation server**{#setting-collation-server} {{ tag-all }}

  [Алгоритм сравнения символов](https://dev.mysql.com/doc/refman/8.0/en/charset.html) (collation), который кластер {{ MY }} использует при работе с данными и обмене информацией с клиентами {{ MY }}. Выбор алгоритма влияет на работу SQL-функций для сортировки, манипуляций со строками и другие возможности.

  По умолчанию: `utf8mb4_0900_ai_ci`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server).

- **Default authentication plugin**{#setting-authentication-plugin} {{ tag-all }}

  Плагин аутентификации, используемый в кластере {{ mmy-name }}:
  - `mysql_native_password` — метод аутентификации, который использовался в {{ MY }} до внедрения плагинов аутентификации;
  - `sha256_password` — аутентификация с использованием алгоритма хэширования SHA-256 для паролей;
  - `caching_sha2_password` (по умолчанию) — аналогичен `sha256_password`, использует кеширование на стороне сервера для лучшей производительности и предоставляет некоторые дополнительные возможности.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin).

- **Default time zone**{#setting-time-zone} {{ tag-all }}

  Часовой пояс сервера.

  По умолчанию: `Europe/Moscow`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone).

- **Explicit defaults for timestamp**{#setting-defaults-for-timestamp} {{ tag-all }}

  Управляет нестандартными значениями по умолчанию и обработкой `NULL` в столбцах `TIMESTAMP`.

  По умолчанию настройка включена (нестандартное поведение **запрещено**).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp).

- **General log**{#setting-general-log} {{ tag-all }}

  Управляет записью основного лога запросов {{ MY }}.

  По умолчанию запись основного лога запросов выключена.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log).

- **Group concat max len**{#setting-group-concat-max} {{ tag-all }}

  Максимальная длина (в байтах) результата функции [GROUP_CONCAT()](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_group-concat).

  Минимальное значение — `4`, максимальное значение — `33554432` (32 МБ), по умолчанию — `1024` (1 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len)

- **Innodb adaptive hash index**{#setting-adaptive-hash-index} {{ tag-all }}

  Управляет [адаптивным хэш-индексом](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_adaptive_hash_index) InnoDB. Для некоторых видов нагрузки на базу данных может быть полезно отключение этого индекса. Документация {{ MY }} рекомендует провести нагрузочное тестирование на реальных данных, чтобы определить необходимость включения или отключения адаптивного хэш-индекса.

  По умолчанию адаптивный хэш-индекс включен.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index).

- **Innodb buffer pool size**{#setting-buffer-pool-size} {{ tag-all }}

  Размер буфера InnoDB (в байтах), который используется для кеширования данных таблиц и индексов. Буфер большого размера приводит к снижению количества операций ввода-вывода при многократном обращении к одним и тем же данным в таблице.

  Минимальное значение — `134217728` (128 МБ). Максимальное значение и значение по умолчанию [зависят от выбранного класса хостов](#settings-instance-dependent) и задаются в соответствии с таблицей:

  | Количество ГБ RAM на хосте | Значение по умолчанию | Максимальное значение |
  |----------------------------|:---------------------:|:---------------------:|
  | 2                          | `268435456` (0,25 ГБ) | `536870912` (0,5 ГБ)  |
  | 4                          | `1610612736` (1,5 ГБ) | `2684354560` (2,5 ГБ) |
  | ≥ 8                        | `0,5 × RAM`           | `0,8 × RAM`           |

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size).

- **Innodb compression level**{#setting-innodb-compression-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Уровень сжатия `zlib`, используемый для сжатых таблиц и индексов InnoDB.

  Минимальное значение — `0`, максимальное значение — `9`, по умолчанию — `6`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level).

- **Innodb flush log at trx commit**{#setting-flush-log-commit} {{ tag-all }}

  Определяет поведение {{ MY }} для операций подтверждения транзакций (`COMMIT`):
  - `1` (по умолчанию) — строгое следование принципам [ACID](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_acid). Логи пишутся и сбрасываются на диск при подтверждении каждой транзакции.
  - `2` — логи пишутся при подтверждении каждой транзакции, но сбрасываются на диск раз в секунду. В случае сбоя данные транзакций, логи для которых не были сброшены на диск, могут быть утеряны.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit).

- **Innodb ft max token size**{#setting-ft-max-token-size} {{ tag-all }}

  Максимальная длина слов, хранящихся в индексе InnoDB `FULLTEXT`.

  Минимальное значение — `10`, максимальное значение — `84`, по умолчанию — `84`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size).

- **Innodb ft min token size**{#setting-ft-min-token-size} {{ tag-all }}

  Минимальная длина слов, хранящихся в индексе InnoDB `FULLTEXT`.

  Минимальное значение — `0`, максимальное значение — `16`, по умолчанию — `3`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size).

- **Innodb io capacity**{#setting-innodb-io-capacity} {{ tag-all }}

  Количество операций ввода-вывода в секунду (IOPS), доступное всем фоновым операциям InnoDB. Эта настройка влияет на процессы, использующие ввод-вывод (например, сброс данных на диск) и может использоваться для ограничения количества операций ввода-вывода.

  Минимальное значение — `100`, максимальное значение — `100000`, по умолчанию — `200`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity).

- **Innodb io capacity max**{#setting-innodb-io-capacity-max} {{ tag-all }}

  Максимальное количество операций ввода-вывода в секунду (IOPS), доступное всем фоновым операциям InnoDB. Если хост не успевает сбрасывать данные на диск, то InnoDB может начать сбрасывать данные на диск чаще, чем установленный настройкой [Innodb io capacity](#setting-innodb-io-capacity) порог IOPS, не превышая заданного максимального ограничения на IOPS.

  Минимальное значение — `100`, максимальное значение — `100000`, по умолчанию — `2000`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max).

- **Innodb lock wait timeout**{#setting-lock-wait-timeout} {{ tag-all }}

  Максимальное время ожидания блокировки строки (в секундах) для транзакции InnoDB. Если время ожидания истекло, то возвращается ошибка, и текущее выражение SQL откатывается (вся транзакция **не откатывается**).

  Значение настройки можно уменьшить для OLTP-приложений и приложений, которые взаимодействуют с пользователем в интерактивном режиме. Значение настройки можно увеличить, если в приложении есть длительные операции, например, ожидающие завершения больших запросов `INSERT` и `UPDATE` в процессе трансформации большого массива данных из хранилища данных.

  Минимальное значение — `1`, максимальное значение — `28800` (480 минут или 8 часов), по умолчанию — `50`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout).

- **Innodb log buffer size**{#setting-log-buffer-size} {{ tag-all }}

  Размер буфера (в байтах), который InnoDB использует при записи логов на диск. Большой буфер позволяет выполнять большие транзакции без записи лога на диск до подтверждения транзакции, что позволяет экономить ресурсы ввода-вывода.

  Минимальное значение — `1048576` (1 МБ), максимальное значение — `268435456` (256 МБ), по умолчанию — `16777216` (16 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size).

- **Innodb log file size**{#setting-log-file-size} {{ tag-all }}

  Размер одного файла redo-логов InnnoDB (в байтах). Чем больше значение, тем реже требуется сбрасывать [контрольные точки](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_checkpoint) (checkpoints) на диск, что позволяет экономить ресурсы ввода-вывода. Однако большой размер лог-файлов приводит к более медленному восстановлению после сбоев.

  Минимальное значение — `268435456` (256 МБ), максимальное значение — `4294967296` (4 ГБ), по умолчанию — `268435456` (256 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

- **Innodb numa interleave**{#setting-innodb-numa-interleave} {{ tag-all }}

  Управляет политикой [NUMA Interleave](https://www.kernel.org/doc/html/latest/admin-guide/mm/numa_memory_policy.html#components-of-memory-policies) при выделении памяти для буфера InnoDB.

  По умолчанию эта политика выключена.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave).

- **Innodb online alter log max size**{#setting-online-alter-log-max-size} {{ tag-all }}

  Размер временных лог-файлов Innodb (в байтах), получаемых во время [онлайн DDL-запросов](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_online_ddl). Увеличение значения позволяет использовать больше [операций DML](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_dml) во время DDL-запросов, но также увеличивает период времени в конце DDL-запроса, в течение которого таблица заблокирована для применения данных из лога.

  Минимальное значение — `65536` (64 КБ), максимальное значение — `107374182400` (100 ГБ), по умолчанию — `134217728` (128 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size).

- **Innodb page size**{#setting-innodb-page-size} {{ tag-all }}

  Размер страницы для табличных пространств InnoDB (в байтах). Эту настройку нельзя изменить после создания кластера.

  Допустимые значения: `4096` (4 КБ), `8192` (8 КБ), `16384` (16 КБ), `32768` (32 КБ), `65536` (64 КБ). По умолчанию — `16384` (16 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size).

- **Innodb print all deadlocks**{#setting-print-all-deadlocks} {{ tag-all }}

  Управляет выводом всей информации о [взаимных блокировках](https://dev.mysql.com/doc/refman/8.0/en/innodb-deadlocks.html) в лог ошибок. Если эта настройка выключена, то при выполнении команды `SHOW ENGINE INNODB STATUS` будет выведена информация только о последней блокировке.

  По умолчанию вывод всей информации о взаимных блокировках выключен.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks).

- **Innodb purge threads**{#setting-innodb-purge-threads} {{ tag-all }}

  Количество потоков ввода-вывода InnoDB, используемых для [операций очистки](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_purge) (purge). Увеличение количества этих потоков полезно в системах, где операции манипуляции с данными (`INSERT`, `UPDATE`, `DELETE`) выполняются над несколькими таблицами.

  Минимальное значение — `1`, максимальное значение — `16`, по умолчанию — `4`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads).

- **Innodb read io threads**{#setting-innodb-read-io-threads} {{ tag-all }}

  Количество потоков ввода-вывода InnoDB, используемых для операций чтения.

  Минимальное значение — `1`, максимальное значение — `16`, по умолчанию — `4`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads).

- **Innodb status output**{#setting-innodb-status-output} {{ tag-con }}

  Управляет выводом стандартного [монитора](https://dev.mysql.com/doc/refman/8.0/en/innodb-enabling-monitors.html) InnoDB.

  По умолчанию стандартный монитор выключен.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output).

- **Innodb strict mode**{#setting-strict-mode} {{ tag-con }}

  Управляет [строгим режимом](https://dev.mysql.com/doc/refman/8.0/en/glossary.html#glos_strict_mode) Innodb. При включении определенные условия, которые обычно рассматриваются как предупреждения, считаются ошибками.

  По умолчанию строгий режимом Innodb включен.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode).

- **Innodb temp data file max size**{#setting-temp-data-max-size} {{ tag-all }}

  Максимальный размер [временного табличного пространства](https://dev.mysql.com/doc/refman/8.0/en/innodb-temporary-tablespace.html#innodb-global-temporary-tablespace) InnoDB (в байтах).

  Минимальное значение — `0` (не использовать временное табличное пространство), максимальное значение — `107374182400` (100 ГБ), по умолчанию — `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path).

- **Innodb thread concurrency**{#setting-innodb-thread-concurrency} {{ tag-all }}

  Максимальное число потоков, которые могут исполняться внутри InnoDB.

  Минимальное значение — `0` (ограничения отсутствуют), максимальное значение — `1000`, по умолчанию — `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency).

- **Innodb write io threads**{#setting-innodb-write-io-threads} {{ tag-all }}

  Количество потоков ввода-вывода InnoDB, используемых для операций записи.

  Минимальное значение — `1`, максимальное значение — `16`, по умолчанию — `4`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads).

- **Interactive timeout**{#setting-interactive-timeout} {{ tag-all }}

  Интервал времени (в секундах), в течение которого сервер ожидает активности при интерактивном соединении, прежде чем закрыть его.

  Минимальное значение — `600` (10 минут), максимальное значение — `86400` (1 сутки), по умолчанию — `28800` (8 часов).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout).

- **Join buffer size**{#setting-join-buffer-size} {{ tag-all }}

  Минимальный размер буфера (в байтах), который используется для:
  - сканирования простого индекса;
  - сканирования индекса диапазона;
  - полного сканирования таблиц (для операций `JOIN`, не использующих индексы).

  Один буфер указанного размера выделяется на каждую операцию объединения двух таблиц. Увеличьте значение этой настройки, чтобы ускорить операции объединения таблиц, для которых невозможно добавить индексы.

  Минимальное значение — `1024` (1 КБ), максимальное значение — `16777216` (16 МБ), по умолчанию — `262144` (256 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }}

  Определяет тип событий, записываемых в логе ошибок:

  - `2` — ошибки и предупреждения.
  - `3` (по умолчанию) — ошибки, предупреждения и информационные сообщения.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity).

- **Log slow filter**{#setting-log-slow-filter} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Фильтр для лога медленных запросов по типу запроса. Представляет собой строку, которая может содержать любую комбинацию следующих значений, разделенных запятой:

  * `full_scan` — в лог попадут запросы, которые выполняют полное сканирование таблицы.
  * `full_join` — в лог попадут запросы, которые выполняют полное объединение (FULL JOIN, без использования индексов).
  * `tmp_table` — в лог попадут запросы, которые выполняют создание неявной внутренней временной таблицы.
  * `tmp_table_on_disk` — в лог попадут запросы, которые выполняют сохранение временной таблицы на диск.
  * `filesort` — в лог попадут запросы, которые выполняют сортировку файлов.
  * `filesort_on_disk` — в лог попадут запросы, которые выполняют сортировку файлов на диске.

  Если значение фильтра задано, в лог медленных запросов попадают только те запросы, типы которых представлены в фильтре.

  Значение по умолчанию — `""` (пустая строка, фильтрация запросов выключена).

  Подробнее см. в [документации Percona](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter).

- **Log slow rate limit**{#setting-log-slow-rate-limit} {{ tag-all }}

  Настройка указывает, какая часть запросов будет попадать в лог медленных запросов. В зависимости от значения настройки [Log slow rate type](#setting-log-slow-rate-type), настройка применяется к отдельным запросам (`QUERY`) или к сессиям (`SESSION`).

  Если установлено значение `1`, то в лог будут попадать каждый запрос или сессия, которые признаны медленными. При других значениях будет логироваться каждый N-ный запрос или сессия, что снизит нагрузку на кластер.

  Если время обработки запроса превышает значение [Slow query log always write time](#setting-slow-query-log-always-write-time), запрос будет записан в [лог медленных запросов](#setting-slow-query-log) независимо от значения [Log slow rate limit](#setting-log-slow-rate-limit).

  Минимальное значение — `1`, максимальное значение — `1000`, по умолчанию — `1`.

  Подробнее см. в [документации Percona](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit).

- **Log slow rate type**{#setting-log-slow-rate-type} {{ tag-all }}

  Задает тип записей лога медленных запросов для настройки [Log slow rate limit](#setting-log-slow-rate-limit):
  
  * `query` — на уровне запроса;
  * `session` — на уровне сессии.

  Значение по умолчанию — `query`.

  Подробнее см. в [документации Percona](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type).

- **Log slow sp statements**{#setting-log-slow-sp-statements} {{ tag-all }}

  Управляет записью выражений, выполняемых хранимыми процедурами, в лог медленных запросов.

  По умолчанию запись выражений включена.

  Подробнее см. в [документации Percona](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements).

- **Long query time**{#setting-long-query-time} {{ tag-all }}

  Время обработки запроса (в секундах), при превышении которого запрос будет считаться медленным. Чем меньше задано значение настройки, тем больше запросов будет считаться медленными.

  Минимальное значение — `0`, максимальное значение — `3600` (1 час), по умолчанию — `10`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time).

- **Lower case table names**{#setting-lower-case-table-names} {{ tag-all }}

  Определяет тип хранения и сравнения имен таблиц:

  - `0` (по умолчанию) — имена таблиц сохраняются без изменений. Сравнения чувствительны к регистру.
  - `1` — имена таблиц сохраняются в нижнем регистре. Сравнения не чувствительны к регистру.

  Эту настройку нельзя изменить после создания кластера.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names).

- **Max allowed packet**{#setting-max-allowed-packet} {{ tag-all }}

  Максимальный размер (в байтах) одного пакета, строки или параметра, отправляемого функцией [mysql_stmt_send_long_data()](https://dev.mysql.com/doc/c-api/8.0/en/mysql-stmt-send-long-data.html).

  По умолчанию задан небольшой размер, что позволяет отбрасывать некорректные пакеты, которые обычно больше. Увеличьте значение настройки, если вы используете большие BLOB-столбцы или длинные строки.

  Минимальное значение — `1024` (1 КБ), максимальное значение — `134217728` (128 МБ), по умолчанию — `16777216` (16 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet).

- **Max connections**{#setting-max-connections} {{ tag-all }}

  Максимальное количество одновременных подключений, которые может принять хост {{ MY }}.

  Минимальное значение — `10`, максимальное значение и значение по умолчанию [зависят от выбранного класса хостов](#settings-instance-dependent) и задаются формулами:

  - Максимальное значение — `<количество МБ RAM на одном хосте> / 8`.
  - Значение по умолчанию — `<количество МБ RAM на одном хосте> / 32`, но не меньше `100`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections).

- **Max digest length**{#setting-max-digest-length} {{ tag-con }}

  Размер памяти (в байтах), зарезервированной для вычисления [дайджестов нормализованных выражений](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-statement-digests.html).

  Минимальное значение — `1024` (1 КБ), максимальное значение — `8192` (8 КБ), по умолчанию — `1024` (1 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length).

- **Max heap table size**{#setting-max-heap-table-size} {{ tag-all }}

  Максимальный размер пользовательских [MEMORY-таблиц](https://dev.mysql.com/doc/refman/8.0/en/memory-storage-engine.html) (в байтах). Изменение значения этой настройки не влияет на уже существующие MEMORY-таблицы. Эта настройка также используется совместно с [Tmp table size](#setting-tmp-table-size) для ограничения размера внутренних таблиц, хранящихся в оперативной памяти.

  Минимальное значение — `16384` (16 КБ), максимальное значение — `134217728` (128 МБ), по умолчанию — `16777216` (16 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size).

- **Max sp recursion depth**{#setting-max-sp-recursion-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальное количество рекурсивных вызовов хранимых процедур.

  Минимальное значение — `0` (рекурсия выключена), максимальное значение — `255`, по умолчанию — `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth).

- **Mdb offline mode disable lag**{#setting-mdb-offline-mode-disable-lag} {{ tag-all }}

  Задержка репликации (в секундах) перед переключением {{ MY }} в режим `offline_mode = OFF`. Значение должно быть меньше, чем значение настройки [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag).

  Минимальное значение — `60` (1 минута), максимальное значение — `86400` (1 сутки), по умолчанию — `300` (5 минут).

- **Mdb offline mode enable lag**{#setting-mdb-offline-mode-enable-lag} {{ tag-all }}

  Задержка репликации (в секундах) перед переключением {{ MY }} в режим `offline_mode = ON`, чтобы пользователи получили актуальные данные.

  Минимальное значение — `600` (10 минут), максимальное значение — `432000` (5 суток), по умолчанию — `86400` (1 сутки).

- **Mdb preserve binlog bytes**{#setting-mdb-preserve-binlog-bytes} {{ tag-all }}

  Размер бинарных логов (в байтах) для хранения на хостах кластера.
  
  Минимальное значение — `1073741824` (1 ГБайт), максимальное значение — `107374182400` (100 ГБайт), по умолчанию — `1073741824` (1 ГБайт).

- **Mdb priority choice max lag**{#setting-mdb-priority-choice-max-lag} {{ tag-all }}

  Задержка репликации (в секундах) перед изменением роли хоста кластера с реплики на мастер. Значение должно быть меньше, чем значение настройки [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag).

  Минимальное значение — `0`, максимальное значение — `86400` (1 сутки), по умолчанию — `60` (1 минута).

- **Net read timeout**{#setting-net-read-timeout} {{ tag-all }}

  Максимальное время ожидания чтения (в секундах) при передаче данных по сети.

  Минимальное значение — `1`, максимальное значение — `1200` (20 минут), по умолчанию — `30`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout).

- **Net write timeout**{#setting-net-write-timeout} {{ tag-all }}

  Максимальное время ожидания записи (в секундах) при передаче данных по сети.

  Минимальное значение — `1`, максимальное значение — `1200` (20 минут), по умолчанию — `60`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout).

- **Range optimizer max mem size**{#setting-range-optimizer-max-mem-size} {{ tag-all }}

  Максимальное потребление памяти (в байтах) оптимизатором диапазона.

  Минимальное значение — `1048576` (1 МБ), максимальное значение — `268435456` (256 МБ), по умолчанию — `8388608` (8 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size).

- **Regexp time limit**{#setting-regexp-time-limit} {{ tag-all }}

  Ограничение на количество шагов при поиске соответствия (match) с помощью [REGEXP_LIKE()](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-like) и других подобных функций для [работы с регулярными выражениями](https://dev.mysql.com/doc/refman/8.0/en/regexp.html). Таким образом, эта настройка влияет на время выполнения косвенно.

  Минимальное значение — `0` (нет ограничений), максимальное значение — `1048576`. По умолчанию: `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_regexp_time_limit).

- **Rpl semi sync master wait for slave count**{#setting-rpl-wait-slave-count} {{ tag-all }}

  Количество реплик, от которых мастер ожидает ответа при полусинхронной репликации, прежде чем подтвердить транзакцию (`COMMIT`).

  Минимальное значение — `1`, максимальное значение — `2`, по умолчанию — `1`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count).

- **Slave parallel type**{#setting-slave-parallel-type} {{ tag-all }}

  Политика для определения того, какие транзакции могут выполняться параллельно на реплике при включенной многопоточной репликации (такая репликация включается настройкой [Slave parallel workers](#setting-slave-parallel-workers)):
  - `LOGICAL_CLOCK` — транзакции, являющиеся частью группового коммита для одного и того же бинарного лога на источнике, выполняются параллельно на реплике.
  - `DATABASE` (по умолчанию) — транзакции, которые изменяют разные базы данных, выполняются параллельно.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type).

- **Slave parallel workers**{#setting-slave-parallel-workers} {{ tag-all }}

  Устанавливает количество потоков для параллельного выполнения транзакций репликации на реплике.

  Минимальное значение — `0` (многопоточная репликация на реплике выключена), максимальное значение — `64`, по умолчанию — `0`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers).

- **Slow query log**{#setting-slow-query-log} {{ tag-all }}

  Разрешает ведение лога медленных запросов. Запрос считается медленным, если время его выполнения превышает заданное настройкой [Long query time](#setting-long-query-time).

  Допустимые значения:

  * `0` или `OFF`;
  * `1` или `ON`.

  Значение по умолчанию — `OFF`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log).

- **Slow query log always write time**{#setting-slow-query-log-always-write-time} {{ tag-all }}

  Время обработки запроса (в секундах), при превышении которого запрос будет безоговорочно записан в [лог медленных запросов](#setting-slow-query-log), игнорируя настройку [Log slow rate limit](#setting-log-slow-rate-limit).

  Минимальное значение — `0`, максимальное значение — `3600` (1 час), по умолчанию — `10`.

  Подробнее см. в [документации Percona](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time).

- **Sort buffer size**{#setting-sort-buffer-size} {{ tag-all }}

  Размер буфера (в байтах), который используется для сортировок в памяти.

  Минимальное значение — `32768` (32 КБ), максимальное значение — `16777216` (16 МБ), по умолчанию — `262144` (256 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size).

- **Sql mode**{#setting-sql-mode} {{ tag-all }}

  Режимы SQL для кластера {{ MY }}:
  - [ALLOW_INVALID_DATES](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_allow_invalid_dates) — не выполнять полную проверку корректности дат. В этом режиме проверяется, что месяц находится в диапазоне от 1 до 12, а день в диапазоне от 1 до 31. Некорректные даты (например, `2004-04-31`) преобразуются в `0000-00-00` с выдачей предупреждения (warning).
  - [ANSI_QUOTES](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_ansi_quotes) — воспринимать кавычки `"` как кавычки для идентификаторов, но не для строк. В этом режиме для строк следует использовать одинарные кавычки `'` вместо двойных кавычек `"`.
  - [ERROR_FOR_DIVISION_BY_ZERO](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_error_for_division_by_zero) — операция деления на ноль возвращает `NULL` с выдачей предупреждения (warning). Этот режим SQL является устаревшим (deprecated).
  - [HIGH_NOT_PRECEDENCE](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_high_not_precedence) — повышает приоритет операции отрицания (`NOT`) при разборе логических выражений. В этом режиме выражение `NOT a BETWEEN b AND c` будет интерпретировано как `(NOT a) BETWEEN b AND c` вместо `NOT (a BETWEEN b AND c)`.
  - [IGNORE_SPACE](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_ignore_space) — разрешает пробелы между именем функции и открывающей скобкой `(`. Это приводит к тому, что имена встроенных функций интерпретируются как ключевые слова. Идентификаторы объектов, которые совпадают с именами таких функций, должны быть окружены кавычками.
  - [NO_AUTO_VALUE_ON_ZERO](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_auto_value_on_zero) — только вставка `NULL` в столбец с атрибутом `AUTO_INCREMENT` приводит к генерации нового значения для столбца. Обычно новое значение генерируется при вставке `0` или `NULL`, поэтому этот режим полезен, если в таком столбце требуется явно хранить значение `0`.
  - [NO_BACKSLASH_ESCAPES](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_backslash_escapes) — выключает использование обратного слеша `\` в качестве escape-символа. Обратный слеш в этом режиме воспринимается как обычный символ.
  - [NO_DIR_IN_CREATE](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_dir_in_create) — директивы `INDEX DIRECTORY` и `DATA DIRECTORY` игнорируются при создании таблицы.
  - [NO_ENGINE_SUBSTITUTION](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_engine_substitution) — не подставлять движок по умолчанию автоматически в случае недоступности движка, указанного в `CREATE TABLE` или `ALTER TABLE`, и выдать соответствующую ошибку.
  - [NO_UNSIGNED_SUBTRACTION](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_unsigned_subtraction) — разрешен отрицательный результат при вычитании целых чисел, одно из которых беззнаковое (unsigned).
  - [NO_ZERO_DATE](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_zero_date) — влияет на использование даты `0000-00-00`: {#setting-no-zero-date}
    - Если [strict SQL mode](#setting-strict-mode) выключен: использование даты `0000-00-00` допустимо, вставка такой даты приведет к выдаче предупреждения (warning).
    - Если strict SQL mode включен: использование даты `0000-00-00` недопустимо, попытка вставки такой даты приведет к ошибке.

    Этот режим SQL является устаревшим (deprecated).

  - [NO_ZERO_IN_DATE](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_no_zero_in_date) — влияет на использование дат с нулевыми месяцем или днем:
    - Если [strict SQL mode](#setting-strict-mode) выключен: даты с нулевыми месяцем или днем вставляются в виде `0000-00-00` с выдачей предупреждения (warning).
    - Если strict SQL mode включен: использование даты с нулевыми месяцам или днем недопустимо, попытка вставки такой даты приведет к ошибке.

    Этот режим SQL является устаревшим (deprecated).

    См. также: [NO_ZERO_DATE](#setting-no-zero-date).

  - [ONLY_FULL_GROUP_BY](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_only_full_group_by) — запрещает выполнение запросов, в которых `SELECT`, `HAVING` или `ORDER BY` ссылаются на неагрегированные столбцы, которые не упомянуты в `GROUP BY` (поведение в стиле [SQL-92](https://dev.mysql.com/doc/refman/8.0/en/group-by-handling.html)).
  - [PAD_CHAR_TO_FULL_LENGTH](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_pad_char_to_full_length) — выравнивать строки в столбцах `CHAR` пробелами до полной длины. Это не распространяется на столбцы `VARCHAR`.
  - [PIPES_AS_CONCAT](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_pipes_as_concat) — воспринимать `||` как оператор конкатенации (эквивалент [CONCAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat)), а не синоним оператора [OR](https://dev.mysql.com/doc/refman/8.0/en/logical-operators.html#operator_or).
  - [REAL_AS_FLOAT](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_real_as_float) — воспринимать `REAL` как синоним для `FLOAT` (по умолчанию {{ MY }} воспринимает `REAL` как синоним для `DOUBLE`).
  - [STRICT_ALL_TABLES](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_strict_all_tables) — включить строгий режим ([strict SQL mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-strict)) для всех движков.
  - [STRICT_TRANS_TABLES](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_strict_trans_tables) — включить строгий режим ([strict SQL mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-strict)) для всех транзакционных движков и, если возможно, для нетранзакционных движков. {#setting-strict-mode}
  - [TIME_TRUNCATE_FRACTIONAL](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_time_truncate_fractional) — включает обрезку дробной части при вставке значений `TIME`, `DATE` или `TIMESTAMP` в столбец, у которого меньшее число знаков в дробной части (по умолчанию {{ MY }} округляет значение до нужного количества знаков, а не обрезает).
  - [ANSI](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_ansi) — комбинация режимов:
    - `REAL_AS_FLOAT`;
    - `PIPES_AS_CONCAT`;
    - `ANSI_QUOTES`;
    - `IGNORE_SPACE`;
    - `ONLY_FULL_GROUP_BY`.
  - [TRADITIONAL](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_traditional) — комбинация режимов:
    - `STRICT_ALL_TABLES`;
    - `STRICT_TRANS_TABLES`;
    - `NO_ZERO_DATE`;
    - `NO_ZERO_IN_DATE`;
    - `ERROR_FOR_DIVISION_BY_ZERO`;
    - `NO_ENGINE_SUBSTITUTION`;

  Можно выбрать несколько режимов из списка или полностью выключить все настройки SQL Mode.

  По умолчанию используется следующий набор режимов SQL:
  - `ERROR_FOR_DIVISION_BY_ZERO`;
  - `NO_ENGINE_SUBSTITUTION`;
  - `NO_ZERO_DATE`;
  - `NO_ZERO_IN_DATE`;
  - `ONLY_FULL_GROUP_BY`;
  - `STRICT_TRANS_TABLES`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting).

- **Sync binlog**{#setting-sync-binlog} {{ tag-all }}

  Частота синхронизации бинарного лога с диском:
  - `0` — синхронизация отключена, {{ MY }} полагается на операционную систему, которая периодически сбрасывает (flush) содержимое бинарного лога на диск, как для любого другого файла. Этот способ обеспечивает максимальную производительность. Данные могут быть утеряны в случае сбоя питания или операционной системы: транзакции могут быть подтверждены, но еще не синхронизированы с бинарным логом.
  - `1` — бинарный лог синхронизируется с диском перед подтверждением транзакций. Это наиболее безопасный способ, который, однако, может отрицательно влиять на производительность из-за большого количества операций записи. В случае сбоя питания или операционной системы транзакции, не попавшие в бинарный лог, находятся в состоянии подготовки (prepared state). Это позволяет автоматически восстановиться после сбоя и откатить (rollback) транзакции. Гарантируется, что ни одна транзакция из бинарного лога не будет утеряна.
  - `N` — бинарный лог синхронизируется с диском после сбора `N` групп коммита (commit groups) для бинарного лога. В случае сбоя питания или операционной системы транзакции могут быть подтверждены, но еще не синхронизированы с бинарным логом. Этот способ может отрицательно влиять на производительность из-за большого количества операций записи. Чем выше значение `N`, тем выше и производительность, и риск потери данных.

  Минимальное значение — `0`, максимальное значение — `4096`, по умолчанию — `1`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog).

- **Table definition cache**{#setting-table-definition-cache} {{ tag-all }}

  Количество определений таблиц, которые можно поместить в соответствующий кеш. Если в базе данных большое количество таблиц, увеличьте значение этой настройки, чтобы повысить скорость открытия таблиц.

  Минимальное значение — `400`, максимальное значение — `524288`, по умолчанию — `2000`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache).

- **Table open cache**{#setting-table-open-cache} {{ tag-all }}

  Размер кеша открытых таблиц для всех потоков. Если значение переменной [Opened tables](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html#statvar_Opened_tables) велико и вы редко используете [FLUSH_TABLES](https://dev.mysql.com/doc/refman/8.0/en/flush.html#flush-tables), увеличьте значение настройки.

  Увеличение значения этой настройки требует увеличения количества файловых дескрипторов для хостов кластера {{ MY }}.

  Минимальное значение — `400`, максимальное значение — `524288`, по умолчанию — `4000`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache).

- **Table open cache instances**{#setting-table-open-cache-instances} {{ tag-all }}

  Для повышения масштабируемости [кеш открытых таблиц](#setting-table-open-cache) может быть разбит на более мелкие сегменты. Эта настройка задает количество таких сегментов.

  Минимальное значение — `1`, максимальное значение — `32`, по умолчанию — `16`.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances).

- **Thread cache size**{#setting-thread-cache-size} {{ tag-all }}

  Количество потоков, которые кешируются для обработки новых сетевых соединений. При установке нового подключения сначала используются потоки из кеша, а потом создаются новые. Увеличьте значение этой настройки, чтобы повысить производительность в случае, когда устанавливается большое количество новых соединений.

  Минимальное значение — `10`, максимальное значение — `10000`. Значение по умолчанию [зависит от выбранного класса хостов](#settings-instance-dependent) и вычисляется по формуле:

  ```text
  max_connections / 10
  ```

  Здесь `max_connections` — значение по умолчанию для настройки [Max connections](#setting-max-connections) для выбранного класса хостов.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size).

- **Thread stack**{#setting-thread-stack} {{ tag-all }}

  Размер стека (в байтах) для каждого потока. Значение по умолчанию достаточно велико, чтобы обеспечить нормальную работу {{ MY }}. Слишком маленькое значение настройки ограничивает сложность SQL-выражений, глубину рекурсии для хранимых процедур и другие параметры, связанные с потреблением памяти.

  Минимальное значение — `131072` (128 КБ), максимальное значение — `16777216` (16 МБ), по умолчанию — `196608` (192 КБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack).

- **Tmp table size**{#setting-tmp-table-size} {{ tag-all }}

  Максимальный размер временной таблицы в памяти (в байтах). При превышении этого размера таблица будет помещена на диск. Эта настройка не влияет на пользовательские MEMORY-таблицы. Увеличьте значение настройки, если вы выполняете много сложных запросов `GROUP BY` и хосты имеют достаточно оперативной памяти.

  Минимальное значение — `1024` (1 КБ), максимальное значение — `134217728` (128 МБ), по умолчанию — `16777216` (16 МБ).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size).

- **Transaction isolation**{#setting-transaction-isolation} {{ tag-all }}

  Уровень изоляции транзакций по умолчанию:
  - `READ-COMMITTED` — запрос видит только те строки, которые были зафиксированы до начала его выполнения.
  - `REPEATABLE-READ` — все запросы в текущей транзакции видят только те строки, которые были зафиксированы перед первым выполненным в этой транзакции запросом на выборку или изменение данных.
  - `SERIALIZABLE` — уровень аналогичен `REPEATABLE-READ`, за исключением того, что InnoDB неявно конвертирует `SELECT` в `SELECT ... FOR SHARE`, если [autocommit](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) выключен. Если autocommit включен, то `SELECT` находится в своей собственной транзакции в режиме `read only` и может быть сериализован.

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation).

- **Wait timeout**{#setting-wait-timeout} {{ tag-all }}

  Интервал времени (в секундах), в течение которого сервер ожидает активности при неинтерактивном соединении, прежде чем закрыть его.

  Минимальное значение — `600` (10 минут), максимальное значение — `86400` (1 сутки), по умолчанию — `28800` (8 часов).

  Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout).
