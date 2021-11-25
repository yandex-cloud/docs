- **Archive timeout**{#setting-archive-timeout} {{ tag-all }}

  Периодичность (в миллисекундах) архивации лога транзакций {{ PG }}.

  Минимальное значение — `10000`, максимальное значение — `86400000`, по умолчанию — `30000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-ARCHIVE-TIMEOUT).

- **Array nulls**{#setting-array-nulls} {{ tag-all }}

  Управляет распознаванием `NULL` как отдельного элемента при вставке массива в ячейку с соответствующим типом данных.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ARRAY-NULLS).

- **Auto explain log analyze**{#setting-auto-explain-log-analyze} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает вывод статистики плана запроса в лог {{ PG }} с помощью модуля `auto_explain`. Модуль позволяет логировать план выполнения медленных запросов автоматически, обходясь без команды `EXPLAIN`. Это полезно для отслеживания неоптимизированных запросов. Для работы модуля необходимо [подключить библиотеку](#setting-shared-libraries) `auto_explain`.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log buffers**{#setting-auto-explain-log-buffers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает вывод статистики использования буферного кеша в лог {{ PG }} через модуль `auto_explain`. Аналог параметра `BUFFERS` в команде `EXPLAIN`. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log min duration**{#setting-auto-explain-log-min-duration} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Минимальное время выполнения запроса (в миллисекундах), при котором включается логирование в модуле `auto_explain`. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  Минимальное значение — `-1` (логирование отключено), максимальное значение — `2147483647`, по умолчанию — `-1`. При значении `0` логируются планы всех запросов независимо от времени их выполнения.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log nested statements**{#setting-auto-explain-log-nested-statements} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает в модуле `auto_explain` логирование выполнения вложенных запросов внутри SQL-функций. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  По умолчанию настройка выключена (логируются только планы верхнеуровневых запросов).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log timing**{#setting-auto-explain-log-timing} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает в модуле `auto_explain` логирование времени выполнения этапов плана запроса. Аналог параметра `TIMING` в команде `EXPLAIN`. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log triggers**{#setting-auto-explain-log-triggers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает в модуле `auto_explain` вывод статистики выполнения триггеров. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log verbose**{#setting-auto-explain-log-verbose} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает в модуле `auto_explain` детальное логирование. Аналог параметра `VERBOSE` в команде `EXPLAIN`. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain sample rate**{#setting-auto-explain-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Доля запросов в течение одной сессии, которые логируются в модуле `auto_explain`. Применяется только при включенной настройке [Auto explain log analyze](#setting-auto-explain-log-analyze).

  Минимальное значение — `0.0` (никакие запросы не логируются), максимальное значение — `1.0` (логируются все запросы), по умолчанию — `1.0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/auto-explain.html).

- **Autovacuum analyze scale factor**{#setting-autovacuum-analyze-scale-factor} {{ tag-all }}

  Доля измененных или удаленных записей в таблице, по достижении которой [процесс автоочистки](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) запустит процесс сбора статистики командой `ANALYZE`.

  Минимальное значение — `0.0`, максимальное значение — `1.0`, по умолчанию — `0.0001`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-ANALYZE-SCALE-FACTOR).

- **Autovacuum max workers**{#setting-autovacuum-max-workers} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Максимальное количество параллельно запущенных процессов автоочистки. Процесс периодически запускается для каждой БД, определяет, какие из записей в таблицах помечены на удаление, и удаляет их.

  Минимальное значение — `1`, максимальное значение – `32`. Значение по умолчанию [зависит от выбранного класса хостов](#settings-instance-dependent) и равно количеству vCPU на одном хосте, но не может быть меньше `3`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-MAX-WORKERS).

- **Autovacuum naptime**{#setting-autovacuum-naptime} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Минимальный интервал запуска процесса автоочистки (в миллисекундах). Его можно увеличить при частых изменениях данных, чтобы не нагружать БД.

  Минимальное значение — `1000`, максимальное значение — `86400000`, по умолчанию — `15000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-NAPTIME).

- **Autovacuum vacuum cost delay**{#setting-autovacuum-vacuum-cost-delay} {{ tag-all }}

    Время (в миллисекундах) <q>заморозки</q> процесса автоочистки.

    Минимальное значение — `-1` (настройка не применяется), максимальное значение — `100`. Значение по умолчанию [зависит от выбранного класса хостов](#settings-instance-dependent):

    - Если количество vCPU для выбранного класса хостов больше или равно 10, используется значение `5`.
    - В остальных случаях значение по умолчанию рассчитывается по формуле:

        ```text
        55 - 5 × <количество vCPU на одном хосте>
        ```

    Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-DELAY).

- **Autovacuum vacuum cost limit**{#setting-autovacuum-vacuum-cost-limit} {{ tag-all }}

  Целое число, максимальный размер <q>штрафа</q> для [процесса автоочистки](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM). Используется при вычислении истинного времени <q>заморозки</q> процесса: на эту величину делится значение параметра [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay).

  Минимальное значение — `-1` (настройка не применяется), максимальное значение — `10000`. Значение по умолчанию [зависит от выбранного класса хостов](#settings-instance-dependent) и задается формулой:

  ```text
  150 × <количество vCPU на одном хосте> + 400
  ```

  Например, для кластера [класса s2.small](../../managed-postgresql/concepts/instance-types.md) vCPU равно `4` и значение настройки по умолчанию `150 × 4 + 400 = 1000`, а для кластера класса m2.medium (`vCPU = 6`) — `150 × 6 + 400 = 1300`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-LIMIT).

- **Autovacuum vacuum scale factor**{#setting-autovacuum-vacuum-scale-factor} {{ tag-all }}

  Доля измененных или удаленных записей в таблице, по достижении которой [процесс автоочистки](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) запустит сборку и удаление мусора командой `VACUUM`.

  Минимальное значение — `0.0` (настройка не применяется), максимальное значение — `1.0`, по умолчанию — `0.00001`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-SCALE-FACTOR).

- **Autovacuum work mem**{#setting-autovacuum-work-mem} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Объем памяти (в байтах), выделяемый каждому [процессу автоочистки](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  Минимальное значение — `-1` (настройка не применяется), максимальное значение — `2147483647`, по умолчанию — `-1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-AUTOVACUUM-WORK-MEM).

- **Backend flush after**{#setting-backend-flush-after} {{ tag-all }}

  Максимальный объем данных (в килобайтах) в страничном кеше ядра ОС, записываемых служебным процессом. При его превышении СУБД дает команду ОС записать данные на диск. Чем больше параметр, тем меньше вероятность замедления при записи данных на диск (в том числе, после завершения контрольной точки) командой `fsync`.

  Минимальное значение — `0` (настройка не применяется), максимальное значение — `2048`, по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BACKEND-FLUSH-AFTER).

- **Backslash quote**{#setting-backslash-quote} {{ tag-all }}

  Управляет представлением кавычки в SQL-строке.

  Допустимые значения:
   - `backslash_quote` (`BACKSLASH_QUOTE` для Terraform, API и CLI) — кавычка может быть представлена как `\'` (эквивалентно значению `on`);
   - `on` (`BACKSLASH_QUOTE_ON` для Terraform, API и CLI) — кавычка может быть представлена как `\'`;
   - `off` (`BACKSLASH_QUOTE_OFF` для Terraform, API и CLI) — кавычка задается только обычным для SQL способом `''`;
   - `safe_encoding` (`BACKSLASH_QUOTE_SAFE_ENCODING` для Terraform, API и CLI) (по умолчанию) — представление кавычки как `\'` допускается только для клиентских кодировок, не использующих `\` в многобайтных символах.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-BACKSLASH-QUOTE).

- **Bgwriter delay**{#setting-bgwriter-delay} {{ tag-all }}

  Задержка (в миллисекундах) между раундами активности процесса фоновой записи. Этот процесс записывает новые или измененные элементы буферного кеша {{ PG }} на диск. Процесс фоновой записи увеличивает общую нагрузку на диск, так как может многократно записывать страницу при каждом изменении, а не разово в контрольной точке.

  Минимальное значение — `10`, максимальное значение — `10000`, по умолчанию — `200`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-DELAY).

- **Bgwriter flush after**{#setting-bgwriter-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Объем данных, обрабатываемых процессом фоновой записи (в килобайтах), при превышении которого СУБД дает команду ОС сохранить эти данные на диск. Параметр ограничивает объем сырых данных в страничном кеше ядра ОС и уменьшает вероятность замедления при выполнении команды `fsync` по завершении снятия контрольной точки или когда ОС в фоне сбрасывает данные на диск.

  Минимальное значение — `0`, максимальное значение — `2048`, по умолчанию — `512`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-FLUSH-AFTER).

- **Bgwriter lru maxpages**{#setting-bgwriter-lru-maxpages} {{ tag-all }}

  Максимальное число элементов буферного кеша {{ PG }}, которое может сохранить процесс фоновой записи за раунд активности. При нулевом значении фоновая запись отключается.

  Минимальное значение — `0`, максимальное значение — `1073741823`, по умолчанию — `100`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MAXPAGES).

- **Bgwriter lru multiplier**{#setting-bgwriter-lru-multiplier} {{ tag-all }}

  Множитель, на который в следующем раунде активности будет увеличено среднее число буферов, сохраняемых процессом фоновой записи.

  Минимальное значение — `0`, максимальное значение — `10`, по умолчанию — `2`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MULTIPLIER).

- **Bytea output**{#setting-bytea-output} {{ tag-all }}

  Задает формат вывода [бинарных строковых значений](https://www.postgresql.org/docs/current/datatype-binary.html) (тип `bytea`):
   - `hex` (`BYTEA_OUTPUT_HEX` для Terraform, API и CLI) — каждый байт задается двумя шестнадцатеричными символами, например '`SELECT '\xDEADBEEF';`';
   - `escape` (`BYTEA_OUTPUT_ESCAPE` для Terraform, API и CLI) — стандартный формат {{ PG }}, только символы ASCII.

  Значение по умолчанию — `hex`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/datatype-binary.html).

- **Checkpoint completion target**{#setting-checkpoint-completion-target} {{ tag-all }}

  Доля интервала между контрольными точками, определяющая максимальную продолжительность записи страниц памяти при снятии контрольной точки. Например, при значении `0.5` процедура снятия контрольной точки будет завершена примерно за половину времени до начала следующей контрольной точки.

  Минимальное значение — `0.0`, максимальное значение — `1.0`, по умолчанию — `0.5`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/wal-configuration.html)

- **Checkpoint flush after**{#setting-checkpoint-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Объем области памяти (в килобайтах), занимаемой страницами для записи в контрольной точке. Те страницы, которые выходят за границы области, будут сброшены на диск и удалены из страничного кеша ОС.

  Минимальное значение — `0`, максимальное значение — `2048`, по умолчанию — `256`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-FLUSH-AFTER)

- **Checkpoint timeout**{#setting-checkpoint-timeout} {{ tag-all }}

  Интервал между контрольными точками (в миллисекундах).

  Минимальное значение — `30000`, максимальное значение — `86400000`, по умолчанию — `300000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-TIMEOUT).

- **Client min messages**{#setting-client-min-messages} {{ tag-all }}

  Уровень сообщений логирования, отправляемых клиентским приложениям. Возможные значения (по возрастанию важности): `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `log`, `fatal` и `panic` (для Terraform, API, CLI `LOG_LEVEL_DEBUG5`, `LOG_LEVEL_DEBUG4`, `LOG_LEVEL_DEBUG3`, `LOG_LEVEL_DEBUG2`, `LOG_LEVEL_DEBUG1`, `LOG_LEVEL_INFO`, `LOG_LEVEL_NOTICE`, `LOG_LEVEL_WARNING`, `LOG_LEVEL_ERROR`, `LOG_LEVEL_LOG`, `LOG_LEVEL_FATAL` и `LOG_LEVEL_PANIC`).

  Значение по умолчанию — `NOTICE`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-CLIENT-MIN-MESSAGES).

- **Constraint exclusion**{#setting-constraint-exclusion} {{ tag-all }}

  Разрешает планировщику использовать ограничения таблиц для оптимизации запросов.

  Допустимые значения:
   - `on` (`CONSTRAINT_EXCLUSION_ON` для Terraform, API и CLI) — задействовать ограничения для всех таблиц;
   - `off` (`CONSTRAINT_EXCLUSION_OFF` для Terraform, API и CLI) — не задействовать ограничения;
   - `partition` (`CONSTRAINT_EXCLUSION_PARTITION` для Terraform, API и CLI) (по умолчанию) — задействовать ограничения только для дочерних таблиц и подзапросов `UNION ALL`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CONSTRAINT-EXCLUSION).

- **Cursor tuple fraction**{#setting-cursor-tuple-fraction} {{ tag-all }}

  Задает для планировщика оценку доли строк, которые будут получены через курсор.

  Минимальное значение — `0.0`, максимальное значение — `1.0`, по умолчанию — `0.1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CURSOR-TUPLE-FRACTION).

- **Deadlock timeout**{#setting-deadlock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Время ожидания (в миллисекундах), по истечении которого будет выполняться проверка состояния перекрестной блокировки.

  Минимальное значение — `1`, максимальное значение — `2147483647`, по умолчанию — `1000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-DEADLOCK-TIMEOUT).

- **Default statistics target**{#setting-default-statistics-target} {{ tag-all }}

  Максимальное число записей статистики по каждому столбцу таблиц БД. С помощью статистики планировщик запросов оценивает число строк, возвращаемых запросами, чтобы выбрать наиболее подходящий план запроса.

  Увеличивая значение настройки, можно увеличить точность оценок планировщика.

  Минимальное значение — `1`, максимальное значение — `10000`, по умолчанию — `1000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-DEFAULT-STATISTICS-TARGET).

- **Default transaction isolation**{#setting-default-transaction-isolation} {{ tag-all }}

  Определяет уровень изоляции по умолчанию для новых транзакций SQL.

  Допустимые значения:
  - `read committed` (`TRANSACTION_ISOLATION_READ_COMMITTED` для Terraform, API и CLI) (по умолчанию) — запрос видит только те строки, которые были зафиксированы до начала его выполнения.
  - `read uncommitted` (`TRANSACTION_ISOLATION_READ_UNCOMMITTED` для Terraform, API и CLI) — поведение этого уровня изоляции в {{ PG }} идентично `read committed`.
  - `repeatable read` (`TRANSACTION_ISOLATION_REPEATABLE_READ` для Terraform, API и CLI) — все запросы в текущей транзакции видят только те строки, которые были зафиксированы перед первым выполненным в этой транзакции запросом на выборку или изменение данных.
  - `serializable` (`TRANSACTION_ISOLATION_SERIALIZABLE` для Terraform, API и CLI) — обеспечивает самый строгий уровень изоляции из всех приведенных выше. Поведение этого уровня изоляции в {{ PG }} аналогично `repeatable read`. Однако, если наложение операций чтения и записи параллельных сериализуемых транзакций несовместимо с их последовательным выполнением, произойдет откат одной из транзакций с ошибкой «сбой сериализации».

  Подробнее об уровнях изоляции см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/transaction-iso.html).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Default transaction read only**{#setting-default-transaction-read-only} {{ tag-all }}

  Устанавливает режим «только чтение» в каждой новой транзакции для обычных (не временных) таблиц.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DEFAULT-TRANSACTION-READ-ONLY).

- **Default with oids**{#setting-default-with-oids} {{ tag-all }}

  Добавляет столбец `OID` с уникальным идентификатором строки. Настройка действует, если таблица создается:
    - либо без указания `WITH OIDS` и `WITHOUT OIDS`,
    - либо с помощью команды `SELECT INTO`.

  Практика использования `OID` в пользовательских таблицах считается устаревшей, параметр следует включать только для совместимости со старыми приложениями.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/11/runtime-config-compatible.html#GUC-DEFAULT-WITH-OIDS).

- **Effective cache size**{#setting-effective-cache-size} {{ tag-all }}

  Оценка (в байтах) эффективного размера дискового кеша, доступного для одного запроса. Используется планировщиком запросов: увеличение этого значения повышает вероятность применения сканирования по индексу, а уменьшение — вероятность выбора последовательного сканирования.

  Минимальное значение — `0`, максимальное значение — `549755813888` (512 ГБ), по умолчанию — `107374182400` (100 ГБ).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-EFFECTIVE-CACHE-SIZE).

- **Effective io concurrency**{#setting-effective-io-concurrency} {{ tag-all }}

  Максимальное число параллельных операций дискового ввода-вывода в отдельной сессии работы с БД. Чем больше это число, тем больше операций {{ PG }} будет пытаться выполнить параллельно в отдельной сессии.

  Минимальное значение — `0`, максимальное значение — `1000`, по умолчанию — `1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-EFFECTIVE-IO-CONCURRENCY).

- **Enable bitmapscan**{#setting-enable-bitmapscan} {{ tag-all }}

  Разрешает планировщику сканировать битовую карту индекса при просмотре таблиц, даже если это явно не указано в запросе. Этот способ доступа похож на обычный индексный доступ, но происходит в два этапа:

   1. Сканируется индекс (Bitmap Index Scan) и строится битовая карта, в которой отмечаются те строки, которые должны быть прочитаны в запросе.
   1. Выполняется сканирование таблицы (Bitmap Heap Scan). При этом:
      - страницы читаются последовательно (увеличивается шанс воспользоваться кешем ОС);
      - каждая страница просматривается ровно один раз.

   Это может ускорить выполнение запросов.

   По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-BITMAPSCAN).

- **Enable hashagg**{#setting-enable-hashagg} {{ tag-all }}

  Разрешает планировщику строить хеш-таблицу из набора результатов, даже если это явно не указано в запросе. Настройка эффективна при частых запросах без сортировок к таблицам с большим объемом данных.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHAGG).

- **Enable hashjoin**{#setting-enable-hashjoin} {{ tag-all }}

  Разрешает планировщику строить объединения (`JOIN`) таблиц по хеш-значениям строк, даже если это явно не указано в запросе. Настройка эффективна при работе с большими объемами данных и тогда, когда таблицы не отсортированы по столбцам, по которым производится объединение.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHJOIN).

- **Enable indexonlyscan**{#setting-enable-indexonlyscan} {{ tag-all }}

  Разрешает планировщику использовать сканирование индекса таблиц без обращения к данным, даже если это явно не указано в запросе.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/indexes-index-only-scans.html).

- **Enable indexscan**{#setting-enable-indexscan} {{ tag-all }}

  Разрешает планировщику использовать сканирование индекса таблиц, даже если это явно не указано в запросе.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INDEXSCAN).

- **Enable material**{#setting-enable-material} {{ tag-all }}

  Разрешает планировщику использовать запросы материализации.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MATERIAL).

- **Enable mergejoin**{#setting-enable-mergejoin} {{ tag-all }}

  Разрешает планировщику использовать слияние операций `JOIN` при объединении таблиц.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MERGEJOIN).

- **Enable nestloop**{#setting-enable-nestloop} {{ tag-all }}

  Разрешает планировщику использовать объединения (`JOIN`) с вложенными циклами. При выключенной настройке планировщик будет использовать другие методы.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-NESTLOOP).

- **Enable parallel append**{#setting-enable-parallel-append} {{ tag-all }}

  Разрешает планировщику использовать распараллеливание при добавлении данных.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-APPEND).

- **Enable parallel hash**{#setting-enable-parallel-hash} {{ tag-all }}

  Разрешает планировщику строить объединения по хешу строк с распараллеливанием хеширования. Настройка действует при включенной настройке [Enable hashjoin](#setting-enable-hashjoin).

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-HASH).

- **Enable partition pruning**{#setting-enable-partition-pruning} {{ tag-all }}

  Разрешает планировщику удалять ненужные партиции из планов запроса к партиционированным таблицам.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/ddl-partitioning.html#DDL-PARTITION-PRUNING).

- **Enable partitionwise aggregate**{#setting-enable-partitionwise-aggregate} {{ tag-all }}

  Разрешает планировщику группировать или агрегировать данные с учетом партиций, что позволяет выполнять запросы для каждой партиции отдельно.

  По умолчанию настройка выключена (планировщик не учитывает партиционирование).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-AGGREGATE).

- **Enable partitionwise join**{#setting-enable-partition-join} {{ tag-all }}

  Разрешает планировщику использовать партиционирование таблиц при планировании запросов. Настройка позволяет выполнять запросы объединения партиционированных таблиц через объединение соответствующих партиций.

  По умолчанию настройка выключена (планировщик не учитывает партиционирование).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-JOIN).

- **Enable seqscan**{#setting-enable-seqscan} {{ tag-all }}

  Разрешает планировщику использовать планы последовательного сканирования таблиц.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-ENABLE).

- **Enable sort**{#setting-enable-sort} {{ tag-all }}

  Разрешает планировщику использовать шаги с явной сортировкой.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-SORT).

- **Enable tidscan**{#setting-enable-tidscan} {{ tag-all }}

  Разрешает планировщику запросов сканировать системные идентификаторы записей (CTID, column tuple identifier). Это может ускорить выполнение запросов.

  По умолчанию настройка включена (планировщик выполняет сканирование CTID).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/ddl-system-columns.html).

- **Escape string warning**{#setting-escape-string-warning} {{ tag-all }}

  Включает выдачу предупреждения сервером СУБД при наличии символа `\` в обычной строковой константе (с синтаксисом `'...'`) в запросе.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ESCAPE-STRING-WARNING).

- **Exit on error**{#setting-exit-on-error} {{ tag-all }}

  Включает прерывание сессии в случае любой ошибки в запросе.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-error-handling.html).

- **Force parallel mode**{#setting-force-parallel-mode} {{ tag-all }}

  Позволяет распараллеливать запрос в целях тестирования:
   - `off` (`FORCE_PARALLEL_MODE_OFF` для Terraform, API и CLI) — использовать параллельный режим только когда ожидается увеличение производительности.
   - `on` (`FORCE_PARALLEL_MODE_ON` для Terraform, API и CLI) — принудительно распараллеливать все запросы, для которых это безопасно.
   - `regress` (`FORCE_PARALLEL_MODE_REGRESS` для Terraform, API и CLI) — эквивалентен `on`, но стандартный вывод не отличается от выполнения в не параллельном режиме.

  По умолчанию `off`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FORCE-PARALLEL-MODE).

- **From collapse limit**{#setting-from-collapse-limit} {{ tag-all }}

  Максимальное количество элементов в списке `FROM`. Пока оно не превышено, планировщик будет объединять вложенные запросы с внешним запросом. При уменьшении значения сокращается время планирования, но план запроса может стать менее эффективным.

  Минимальное значение — `1`, максимальное значение — `2147483647`, по умолчанию — `8`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FROM-COLLAPSE-LIMIT).

- **Gin pending list limit**{#setting-gin-list-limit} {{ tag-all }}

  Максимальный размер (в байтах) очереди записей [индекса GIN](https://www.postgresql.org/docs/current/gin-intro.html). Очередь используется, когда включен режим `fastupdate`. Если размер очереди превышает заданный предел, записи из нее массово переносятся в основную структуру данных индекса GIN, а очередь очищается.

  Минимальное значение — `64`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `4194304`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-GIN-PENDING-LIST-LIMIT).

- **Hash mem multiplier**{#setting-hash-mem-multiplier} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Определяет максимальный объем памяти, доступный для операций с хеш-таблицами. Объем вычисляется умножением значения настройки на величину параметра [Work mem](#setting-work-mem).

  Минимальное значение — `0.0`, максимальное значение — `1000.0`, по умолчанию — `1.0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-HASH-MEM-MULTIPLIER).

- **Idle in transaction session timeout**{#setting-idle-session-timeout} {{ tag-all }}

  Время простоя открытой транзакции (в миллисекундах), при превышении которого будет завершена сессия с этой транзакцией.

  Минимальное значение — `0`, максимальное значение — `2147483647`, по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT).

- **Jit**{#setting-jit} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Включает [JIT-компиляцию запросов](https://www.postgresql.org/docs/current/jit.html) (just-in-time compilation) для {{ PG }}. Если настройка включена, то SQL-запросы компилируются в машинный код прямо во время выполнения. Это может ускорить выполнение сложных запросов, которые требовательны к ресурсам CPU.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JIT).

- **Join collapse limit**{#setting-join-collapse-limit} {{ tag-all }}

  Максимальное количество элементов в списке `FROM`. Пока оно не превышено, планировщик будет переносить в список явные инструкции `JOIN` (за исключением `FULL JOIN`). При уменьшении значения сокращается время планирования, но план запроса может стать менее эффективным.

  Минимальное значение — `1`, максимальное значение — `2147483647`, по умолчанию — `8`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JOIN-COLLAPSE-LIMIT).

- **Lo compat privileges**{#setting-lo-compat-privileges} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Отключает проверку прав доступа для больших объектов. До версии 9.0 права доступа не действовали на большие объекты, и они были доступны для чтения и записи всем пользователям. Не включайте настройку, если требуется совместимость с версиями {{ PG }} ниже 9.0.

  По умолчанию настройка выключена (проверки прав доступа включены).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-LO-COMPAT-PRIVILEGES).

- **Lock timeout**{#setting-lock-timeout} {{ tag-all }}

  Определяет, сколько ждать освобождения блокировки (в миллисекундах). Заблокированными могут быть: таблица, индекс, строка или другие объекты базы данных. Если время ожидания для какой-либо операции истекло, то она прерывается.

  Минимальное значение — `0` (контроль длительности отключен, ожидать получения блокировки можно сколь угодно долго), максимальное значение — `2147483647`, по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-LOCK-TIMEOUT).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log checkpoints**{#setting-log-checkpoints} {{ tag-all }}

  Управляет логированием выполнения контрольных точек и точек перезапуска сервера.

  По умолчанию настройка выключена (логирование не ведется).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CHECKPOINTS).

- **Log connections**{#setting-log-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Управляет логированием всех попыток подключения к серверу {{ PG }}, в том числе тех, для которых была успешно завершена аутентификация клиентов.

  По умолчанию настройка выключена (логирование не ведется).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CONNECTIONS).

- **Log disconnections**{#setting-log-disconnections} {{ tag-con }} {{ tag-api }} {{tag-cli }} {{ tag-tf }}

  Управляет логированием завершения сессий подключения к серверу {{ PG }}.

  По умолчанию настройка выключена (логирование не ведется).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DISCONNECTIONS).

- **Log duration**{#setting-log-duration} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Управляет логированием длительности каждой завершенной команды.

  По умолчанию настройка выключена (логирование не выполняется).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DURATION).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Уровень детализации информации, записываемой в лог {{ PG }} для каждого сообщения. Уровни детализации лога в порядке увеличения информативности:

  - `terse` (`LOG_ERROR_VERBOSITY_TERSE` для Terraform, CLI и API). Из сообщения об ошибке исключаются поля `DETAIL`, `HINT`, `QUERY` и `CONTEXT`.
  - `default` (`LOG_ERROR_VERBOSITY_DEFAULT` для Terraform, CLI и API). По умолчанию.
  - `verbose` (`LOG_ERROR_VERBOSITY_VERBOSE` для Terraform, CLI и API). В сообщение об ошибке включается код ошибки `SQLSTATE`, а также имя файла с исходным кодом, имя функции и номер строки, сгенерировавшей ошибку.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-ERROR-VERBOSITY).

- **Log lock waits**{#setting-log-lock-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Управляет логированием продолжительных ожиданий блокировки. При включенной настройке делается запись в логе, когда в сессии {{ PG }} время ожидания получения блокировки дольше значения настройки [Deadlock timeout](#setting-deadlock-timeout).

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-LOCK-WAITS).

- **Log min duration sample**{#setting-log-min-duration-sample} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Настройка работает также, как [Log min duration statement](#setting-log-min-duration-statement), но применяется только к командам, указанным в параметре [Log statement sample rate](#setting-log-statement-sample-rate).

  При значении `0` логируется время работы всех указанных команд.

  Минимальное значение — `-1` (отключает логирование времени работы команд), максимальное значение — `2147483647`, по умолчанию — `-1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-SAMPLE).

- **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Настройка задает порог для логирования времени (в миллисекундах). Будет логироваться время работы только команд, которые выполнялись дольше указанного значения.

  При значении `0` логируется время работы всех команд.

  Минимальное значение — `-1` (отключает логирование времени работы), максимальное значение — `2147483647`, по умолчанию — `-1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-STATEMENT).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log min error statement**{#setting-log-min-error-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Определяет уровень логирования ошибок выполнения команд SQL. Сообщение о выполнении команды будет записано в лог, если он завершится ошибкой с указанным уровнем важности или выше. Возможные значения: `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL` и `PANIC`.

  По умолчанию используется `ERROR`. Это означает, что в лог {{ PG }} будут записаны все команды, завершившиеся сообщением с уровнем важности `ERROR`, `LOG`, `FATAL` и `PANIC`.

  Чтобы отключить запись команд с ошибками, выберите значение `PANIC`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-ERROR-STATEMENT).

- **Log min messages**{#setting-log-min-messages} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Определяет уровень логирования {{ PG }}. Записываются все сообщения выбранного уровня важности и выше. Возможные значения (по возрастанию важности): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL` и `PANIC`.

  По умолчанию используется `WARNING`. Это означает, что в лог {{ PG }} будут записаны все сообщения с уровнем важности `WARNING`, `ERROR`, `LOG`, `FATAL` и `PANIC`.

  Чтобы отключить запись сообщений, выберите значение `PANIC`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-MESSAGES).

- **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Фильтр команд SQL, которые должны записываться в лог {{ PG }}:
  - `none` (`LOG_STATEMENT_NONE` для Terraform, CLI и API) (по умолчанию) — фильтр отключен, команды SQL не записываются в лог.
  - `ddl` (`LOG_STATEMENT_DDL` для Terraform, CLI и API) — в лог записываются команды SQL, которые позволяют изменять определения структур данных (такие как `CREATE`, `ALTER`, `DROP` и подобные им).
  - `mod` (`LOG_STATEMENT_MOD` для Terraform, CLI и API) — в лог записываются команды SQL, попадающие под фильтр `ddl`, и команды, позволяющие изменять данные (такие как `INSERT`, `UPDATE` и подобные им).
  - `all` (`LOG_STATEMENT_ALL` для Terraform, CLI и API) — в лог записываются все команды SQL.

  Подробнее см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log statement sample rate**{#setting-log-statement-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Доля команд SQL, которые будут записываться в лог дополнительно (помимо команд, записываемых по другим причинам).

  Минимальное значение — `0.0`, максимальное значение — `1.0`, по умолчанию — `0.0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-STATEMENT-SAMPLE-RATE).

- **Log temp files**{#setting-log-temp-files} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Размер временных файлов (в байтах), при превышении которого информация об удалении файла записывается в лог {{ PG }}.

  Минимальное значение — `-1` (не применяется), максимальное значение — `2147483647` (2 ГБ), по умолчанию — `-1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TEMP-FILES).

- **Log transaction sample rate**{#setting-log-transaction-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Доля транзакций, команды из которых будут записываться в лог дополнительно (помимо команд, записываемых по другим причинам).

  Минимальное значение — `0.0`, максимальное значение — `1.0`, по умолчанию — `0.0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TRANSACTION-SAMPLE-RATE).

- **Maintenance work mem**{#setting-maintenance-work-mem} {{ tag-all }}

  Максимальный объем памяти (в байтах) для операций обслуживания {{ PG }}, в частности `VACUUM`, `CREATE INDEX` и `ALTER TABLE ADD FOREIGN KEY`.

  Минимальное значение — `1024`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `65536`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-WORK-MEM).

- **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

    Максимальное число одновременных подключений к хосту {{ PG }}.

    Минимальное значение — `1`, максимальное значение и значение по умолчанию [зависят от выбранного класса хостов](#settings-instance-dependent) и задаются формулой:

    ```text
    200 × <количество vCPU на одном хосте>
    ```

    По умолчанию установлено максимальное значение.

    Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

- **Max locks per transaction**{#setting-max-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальное число объектов, которые могут быть одновременно заблокированы, в расчете на одно подключение к хосту {{ PG }}.

  Минимальное значение — `10`, максимальное значение — `2147483647`, по умолчанию — `64`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-LOCKS-PER-TRANSACTION).

- **Max parallel maintenance workers**{#setting-max-parallel-maintenance-workers} {{ tag-all }}

  Максимальное число параллельно работающих процессов {{ PG }}, инициированных одной служебной командой (например, `CREATE INDEX`).

  Минимальное значение — `0`, максимальное значение — `1024`, по умолчанию — `2`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-MAINTENANCE).

- **Max parallel workers**{#setting-max-parallel-workers} {{ tag-all }}

  Максимальное число параллельно работающих процессов {{ PG }}.

  Минимальное значение — `0`, максимальное значение — `1024`, по умолчанию — `8`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS).

- **Max parallel workers per gather**{#setting-max-parallel-workers-gather} {{ tag-all }}

  Максимальное число параллельно работающих процессов, которые могут запускаться одним узлом [Gather](https://www.postgresql.org/docs/current/how-parallel-query-works.html).

  Минимальное значение — `0`, максимальное значение — `1024`, по умолчанию — `2`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-PER-GATHER).

- **Max pred locks per transaction**{#setting-max-pred-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальное число объектов, которые могут быть одновременно заблокированы [предикатными блокировками](https://www.postgresql.org/docs/13/transaction-iso.html#XACT-SERIALIZABLE), в расчете на одно подключение к хосту {{ PG }}.

  Минимальное значение — `10`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `64`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-PRED-LOCKS-PER-TRANSACTION).

- **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальное число транзакций, которые могут одновременно находиться в [подготовленном состоянии](https://www.postgresql.org/docs/current/sql-prepare-transaction.html).

  Минимальное значение — `0`, максимальное значение — `262143`, по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PREPARED-TRANSACTIONS).

- **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Максимальный размер файлов лога [WAL](https://www.postgresql.org/docs/current/wal-intro.html), при репликации (в байтах).

  Минимальное значение — `-1` (не ограничен), максимальное значение — `2251799812636672` (2 ТБ), по умолчанию — `1073741824`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE).

- **Max standby streaming delay**{#setting-max-standby-streaming-delay} {{ tag-all }}

  Время ожидания (в миллисекундах), по истечении которого хост-реплика в режиме горячего резерва начнет отменять запросы, конфликтующие с очередными изменениями в [WAL](https://www.postgresql.org/docs/current/wal-intro.html).

  Минимальное значение — `-1`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `30000`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-STANDBY-STREAMING-DELAY).

- **Max wal size**{#setting-max-wal-size} {{ tag-all }}

  Максимальный размер (в байтах) файла [WAL](https://www.postgresql.org/docs/current/wal-intro.html), при достижении которого запускается снятие автоматических контрольных точек.

  Минимальное значение — `2`, максимальное значение [зависит от размера хранилища](#settings-instance-dependent) и равно 10% от этой величины, но не более `8589934592` (8 ГБ). По умолчанию установлено максимальное значение.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MAX-WAL-SIZE).

- **Max worker processes**{#setting-max-worker-processes} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальное число фоновых процессов {{ PG }}, которое можно запустить в текущей системе.

  Минимальное значение — `0`, максимальное значение — `1024`, по умолчанию — `8`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-WORKER-PROCESSES).

- **Min wal size**{#setting-min-wal-size} {{ tag-all }}

  Объем дискового пространства (в байтах), занимаемый [WAL](https://www.postgresql.org/docs/current/wal-intro.html), при превышении которого старые файлы WAL в контрольных точках удаляются.

  Минимальное значение — `2`, максимальное значение [зависит от размера хранилища](#settings-instance-dependent) и равно 5% от этой величины, но не более `1073741824` (1 ГБ). По умолчанию установлено максимальное значение.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MIN-WAL-SIZE).

- **Old snapshot threshold**{#setting-old-snapshot-threshold} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Минимальное время (в миллисекундах), в течение которого можно пользоваться снимком состояния для выполнения запроса без риска получить ошибку.

  Минимальное значение — `-1` (не ограничено), максимальное значение — `86400000` (24 часа), по умолчанию — `-1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-OLD-SNAPSHOT-THRESHOLD).

- **Online analyze enable**{#setting-online-analyze} {{ tag-con }} {{ tag-api }}

  Включает использование модуля `online_analyze`, который обновляет статистику после операций `INSERT`, `UPDATE`, `DELETE` или `SELECT INTO` в целевых таблицах.

- **Operator precedence warning**{#setting-operator-precedence-warning} {{ tag-all }}

  Разрешает анализатору запроса выдавать предупреждение для всех конструкций, которые поменяли поведение после версии 9.4 в результате изменения приоритетов команд.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-OPERATOR-PRECEDENCE-WARNING).

- **Parallel leader participation**{#setting-parallel-leader-participation} {{ tag-all }}

  Разрешает ведущему процессу выполнять план запроса ниже узлов Gather и Gather Merge, не ожидая рабочие процессы.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PARALLEL-LEADER-PARTICIPATION).

- **Pg hint plan debug print**{#setting-pghint-plan-debug} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Уровень вывода и детализации отладочной информации модулем `pg_hint_plan`. Действует при включенной настройке [Pg hint plan enable hint](#setting-pg-hint-plan-enable). Возможные значения:
    - `off` (`PG_HINT_PLAN_DEBUG_PRINT_OFF` для Terraform и API) — вывод отключен;
    - `on` (`PG_HINT_PLAN_DEBUG_PRINT_ON` для Terraform и API) — по умолчанию;
    - `detailed` (`PG_HINT_PLAN_DEBUG_PRINT_DETAILED` для Terraform и API);
    - `verbose` (`PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` для Terraform и API).

- **Pg hint plan enable hint**{#setting-pg-hint-plan-enable} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает использование модуля `pg_hint_plan` для корректировки автоматических планов выполнения запросов, применяя так называемые «указания» в виде простых описаний в особых SQL-комментариях.

- **Pg hint plan enable hint table**{#setting-pg-hint-plan-enable-hint-table} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Включает использование таблицы с «указаниями» для модуля `pg_hint_plan`. Когда нет возможности редактировать запросы, указания можно поместить в специальную таблицу `hint_plan.hints`. Таблица содержит следующие столбцы:

  - `id` — Уникальный номер строки с указанием. Этот столбец заполняется автоматически.
  - `norm_query_string`	— шаблон для выбора запросов, к которым будет относиться указание. Константы, фигурирующие в целевом запросе, должны заменяться знаками `?`. Пробельные символы в шаблоне являются значимыми.
  - `application_name` — приложение-инициатор сессий, в которых будет действовать указание.
  - `hint` — поле должно содержать указания без обрамляющей разметки комментариев.

- **Pg hint plan message level**{#setting-pghint-plan-message} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Уровень отладочных сообщений модуля `pg_hint_plan`, которые будут попадать в лог {{ PG }}. Действует при включенной настройке [Pg hint plan enable hint](#setting-pg-hint-plan-enable). Возможные значения:
  - `error`,
  - `warning`,
  - `notice`,
  - `info` (по умолчанию),
  - `log`,
  - `debug`.

- **Plan cache mode**{#setting-plan-cache-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Определяет, какой тип плана запроса (общий или специализированный) будет использован при выполнении [подготовленных команд](https://www.postgresql.org/docs/current/sql-prepare.html). Возможные значения:
    - `auto` (`PLAN_CACHE_MODE_AUTO` для Terraform и API) (по умолчанию) — автоматический выбор;
    - `force_custom_plan` (`PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN` для Terraform и API) — принудительно использовать специализированные планы;
    - `force_generic_plan` (`PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` для Terraform и API) — принудительно использовать общие планы.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PLAN-CACHE_MODE).

- **Plantuner fix empty table**{#setting-plantuner-fix-empty-table} {{ tag-con }} {{ tag-api }}

  Разрешает модулю `plantuner` скрывать от планировщика определенные индексы, так что они не используются в планах запросов.

  По умолчанию настройка выключена.

- **Quote all identifiers**{#setting-quote-identifiers} {{ tag-all }}

  Включает принудительное обрамление кавычками всех идентификаторов при формировании SQL-запросов из базы данных, например, при выполнении операции `EXPLAIN`.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-QUOTE-ALL-IDENTIFIERS).

- **Random page cost**{#setting-random-page-cost} {{ tag-all }}

  Приблизительная условная стоимость чтения одной произвольной страницы с диска.

  Минимальное значение — `0`, по умолчанию — `1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-RANDOM-PAGE-COST).

- **Row security**{#setting-row-security} {{ tag-all }}

  Управляет обработкой запросов, к которым применима как минимум одна [политика защиты строк](https://www.postgresql.org/docs/current/sql-createpolicy.html). При выключении настройки такие запросы будут выдавать ошибку.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-ROW-SECURITY).

- **Search path**{#setting-search-path} {{ tag-all }}

  Список имен схем БД через запятую, при обращении к объектам которых можно использовать только имена объектов и не указывать схемы.

  Значение по умолчанию — `$user, public` (схема текущего пользователя и схема `public`).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SEARCH-PATH).

- **Seq page cost**{#setting-seq-page-cost} {{ tag-all }}

  Приблизительная условная стоимость чтения одной страницы с диска при выполнении серии последовательных чтений.

  Минимальное значение — `0`, по умолчанию — `1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).

- **Shared buffers**{#setting-shared-buffers} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Объем памяти (в байтах), который {{ PG }} может использовать для буферов в разделяемой памяти (shared memory).

  Минимальное значение — `16`, максимальное значение [зависит от выбранного класса хостов](#settings-instance-dependent) и равно 25% от общего размера RAM хоста кластера {{ mpg-name }}. По умолчанию установлено максимальное значение.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-SHARED-BUFFERS).

- **Shared preload libraries**{#setting-shared-libraries} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Разделенный запятыми список имен библиотек общего пользования (shared libraries), которые будут загружаться при запуске сервера {{ PG }}. Библиотеки требуются для работы некоторых [расширений {{ PG }}](../../managed-postgresql/operations/cluster-extensions.md).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SHARED-PRELOAD-LIBRARIES).

- **Standard conforming strings**{#setting-standard-strings} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Включает прочтение символа обратной косой черты в обычных строковых константах (`'...'`) не как спецсимвола, а как обычного символа согласно стандарту SQL.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-STANDARD-CONFORMING-STRINGS).

- **Statement timeout**{#setting-statement-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальная длительность (в миллисекундах) выполнения команды, при превышении которой команда прерывается.

  Минимальное значение — `0`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-STATEMENT-TIMEOUT).

- **Synchronize seqscans**{#setting-synchronize-seqscans} {{ tag-all }}

  Управляет синхронизацией обращений при последовательном сканировании больших таблиц, чтобы эти операции читали один блок примерно в одно и то же время. При выключении последовательное сканирование всегда будет начинаться с начала таблицы, как это было принято до версии 8.3.

  По умолчанию настройка включена (синхронизация действует).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-SYNCHRONIZE-SEQSCANS).

- **Synchronous commit**{#setting-synchronous-commit} {{ tag-all }}

  Определяет, будет ли СУБД выполнять операцию подтверждения транзакции синхронно. Синхронность операции означает, что кластер будет ждать выполнения синхронных операций, гарантирующих различные уровни сохранности и видимости данных в кластере, прежде чем подтвердить транзакцию клиенту.

  Допустимые значения:
  - `off` (`SYNCHRONOUS_COMMIT_OFF` для Terraform, CLI и API) — транзакция подтверждается, даже если данные еще не попали в [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write Ahead Log). Синхронной записи нет, данные о транзакции могут быть потеряны в результате сбоя дисковой подсистемы.
  - `on` (`SYNCHRONOUS_COMMIT_ON` для Terraform, CLI и API) (по умолчанию) — транзакция подтверждается, если WAL записан на диск мастера и на диск синхронной реплики.
  - `local` (`SYNCHRONOUS_COMMIT_LOCAL` для Terraform, CLI и API) — транзакция подтверждается, если WAL записан на диск мастера.
  - `remote_apply` (`SYNCHRONOUS_COMMIT_REMOTE_APPLY` для Terraform, CLI и API) — транзакция подтверждается, если WAL записан на диск мастера, синхронная реплика приняла WAL и применила изменения из него.
  - `remote_write` (`SYNCHRONOUS_COMMIT_REMOTE_WRITE` для Terraform, CLI и API) — транзакция подтверждается, если WAL записан на диск мастера, синхронная реплика приняла WAL и передала его операционной системе для записи на диск. В случае потери дисковой системы мастера и сбоя операционной системы на реплике данные транзакции с таким уровнем синхронизации могут быть утеряны.

  Подробнее см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Temp buffers**{#setting-temp-buffers} {{ tag-all }}

  Максимальный объем памяти (в байтах), выделяемой для временных буферов в каждой сессии.

  Минимальное значение — `100`, максимальное значение — `1073741823` (1 ГБ), по умолчанию — `8388608` (8 МБ).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-BUFFERS).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Максимальный объем дискового пространства (в килобайтах), который один процесс сможет использовать для временных файлов. Транзакция, которая попытается превысить этот предел, будет отменена.

  Большие запросы из-за их размера выполняются не в оперативной памяти, а на диске. Слишком большие запросы могут нагрузить диск и помешать выполнению других запросов. Настройка предотвращает выполнение запросов, которые могут сильно повлиять на производительность, ограничивая размер временных файлов.

  Минимальное значение — `-1` (нет ограничений), максимальное значение — `2147483647` (2 ГБ), по умолчанию — `-1`.

  Подробнее см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-FILE-LIMIT).

  Настройка действует на уровне кластера {{ mpg-name }}, но ее можно [переопределить на уровне пользователя](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Timezone**{#setting-timezone} {{ tag-all }}

  Часовой пояс для вывода и ввода значений времени.

  Значение по умолчанию `Europe/Moscow`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-TIMEZONE).

- **Track activity query size**{#setting-track-activity-query-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Объем памяти (в байтах), резервируемой в каждой активной сессии для хранения текста выполняемой в данной момент команды.

  Минимальное значение — `100`, максимальное значение — `102400`, по умолчанию — `1024`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-ACTIVITY-QUERY-SIZE).

- **Transform null equals**{#setting-transform-null-equals} {{ tag-all }}

  Включает интерпретацию условия `выражение = NULL` как `выражение IS NULL`. Условие истинно, если выражение имеет значение `NULL`, и ложно в противном случае. Согласно стандарту SQL, сравнение `выражение = NULL` всегда возвращает `NULL` (неизвестное значение).

  По умолчанию настройка выключена (действует стандарт SQL).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-TRANSFORM-NULL-EQUALS).

- **Vacuum cleanup index scale factor**{#setting-vacuum-index-scale-factor} {{ tag-all }}

  Доля кортежей в индексе, попавших в предыдущий срез статистики. При выполнении операции `VACUUM` статистика индекса считается устаревшей, если отношение числа кортежей, добавляемых в индекс, к текущему числу кортежей в индексе превышает указанную долю. В этом случае будет выполнено новое сканирование индекса.

  Минимальное значение — `0.0`, максимальное значение — `10000000000.0`, по умолчанию — `0.1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-CLEANUP-INDEX-SCALE-FACTOR).

- **Vacuum cost delay**{#setting-vacuum-cost-delay} {{ tag-all }}

  Время (в миллисекундах), в течение которого будет простаивать процесс выполнения команд `VACUUM` и `ANALYZE`, превысивший предел стоимости (см. настройку [Vacuum cost limit](#setting-vacuum-cost-limit)).

  Минимальное значение — `0`, максимальное значение — `100`, по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-VACUUM-COST).

- **Vacuum cost limit**{#setting-vacuum-cost-limit} {{ tag-all }}

  Условная стоимость, при накоплении которой процесс очистки `VACUUM` будет приостанавливаться (переходить в спящий режим).

  Минимальное значение — `1`, максимальное значение — `10000`, по умолчанию — `200`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-LIMIT).

- **Vacuum cost page dirty**{#setting-vacuum-cost-page-dirty} {{ tag-all }}

  Условная стоимость такой операции очистки `VACUUM`, при которой изменяется блок, не модифицированный ранее.

  Минимальное значение — `0`, максимальное значение — `10000`, по умолчанию — `20`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-DIRTY).

- **Vacuum cost page hit**{#setting-vacuum-cost-page-hit} {{ tag-all }}

  Условная стоимость очистки буфера, оказавшегося в общем кеше.

  Минимальное значение — `0`, максимальное значение — `10000`, по умолчанию — `1`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-HIT).

- **Vacuum cost page miss**{#setting-vacuum-cost-page-miss} {{ tag-all }}

  Условная стоимость очистки буфера, который нужно прочитать с диска.

  Минимальное значение — `0`, максимальное значение — `10000`, по умолчанию — `10`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-MISS).

- **Wal keep size**{#setting-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Минимальный размер устаревших сегментов лога (в байтах), сохраняемых в папке [WAL](https://www.postgresql.org/docs/current/wal-intro.html), чтобы при необходимости [реплики](../../managed-postgresql/concepts/replication.md#replication) могли их загрузить.

  Минимальное значение — `0` (прошлые фрагменты не сохраняются для репликации), максимальное значение — `2251799812636672` (2 ТБ), по умолчанию — `0`.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-WAL-KEEP-SIZE).

- **Wal level**{#setting-wal-level} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Уровень логирования для [WAL](https://www.postgresql.org/docs/current/wal-intro.html). Возможные значения:
    - `WAL_LEVEL_REPLICA` — запись данных, необходимых для WAL и репликации.
    - `WAL_LEVEL_LOGICAL` (по умолчанию) — дополнительно к уровню `WAL_LEVEL_REPLICA` добавляется информация, необходимая для логической репликации.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS).

- **Work mem**{#setting-work-mem} {{ tag-all }}

  Базовый объем памяти (в байтах), который будет использоваться во внутренних операциях при обработке запросов (например, для сортировки или хеш-таблиц), прежде чем будут задействованы временные файлы на диске.

  Минимальное значение — `64`, максимальное значение — `2147483647` (2 ГБ), по умолчанию — `4194304` (4 МБ).

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM).

- **Xmlbinary**{#setting-xmlbinary} {{ tag-all }}

  Способ кодирования двоичных данных в XML. Возможные значения:
  - `base64` (`XML_BINARY_BASE64` для Terraform, API и CLI) (по умолчанию) — BASE64-кодирование;
  - `hex` (`XML_BINARY_HEX` для Terraform, API и CLI) — шестнадцатеричное кодирование.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLBINARY).

- **Xmloption**{#setting-xmloption} {{ tag-all }}

  Тип преобразования XML-данных в символьные по умолчанию. Возможные значения:
  - `document` (`XML_OPTION_DOCUMENT` для Terraform, API и CLI) — XML-документ;
  - `content` (`XML_OPTION_CONTENT` для Terraform, API и CLI) (по умолчанию) — фрагмент XML-документа.

  Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLOPTION).
