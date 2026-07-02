[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Концепции](../overview.md) > Отличия Apache Cloudberry™ от Greenplum®

# Обратно несовместимые изменения в СУБД Apache Cloudberry™ по сравнению с Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL

Apache Cloudberry™ отличается от Greenplum® в ряде аспектов. Значительная часть отличий связана со сменой версии ядра PostgreSQL: Greenplum® основан на версии 9.4.26, а Apache Cloudberry™ — на версии 14.4. Кроме того, есть различия в функциональности, специфичной для каждой из систем.

Эта статья описывает основные отличия и помогает заранее подготовиться к переходу с Greenplum® на Apache Cloudberry™.

## Препятствия для обновления {#update-limitations}

### Несовместимое изменение внутреннего формата типа `jsonb` {#internal-jsonb}

В версиях ядра PostgreSQL, более новых, чем 9.4, внутреннее представление типа `jsonb` было изменено без обеспечения обратной совместимости.

**Как выявить**

Найти все таблицы, использующие `jsonb`:

  ```sql
  SELECT n.nspname, c.relname, a.attname
  FROM pg_attribute a
      JOIN pg_class c ON c.oid = a.attrelid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE a.atttypid = 'jsonb'::regtype
      AND a.attnum > 0;
  ```

**Как исправить**

Пересоздать проблемные столбцы, заменив `jsonb` на `json` или `text`. При необходимости проведите миграцию данных перед удалением столбца с `jsonb`.

### Удаление типов `abstime`, `reltime`, `tinterval` и `unknown` {#type-deletion}

Начиная с версии ядра PostgreSQL 10 тип `unknown` стал псевдотипом.
Начиная с версии ядра PostgreSQL 12, типы `abstime`, `reltime`, `tinterval` были удалены.

В Greenplum® следующие запросы работают без ошибок:

```sql
CREATE TABLE example_abstime (x abstime);

CREATE TABLE example_reltime (x reltime);

CREATE TABLE example_tinterval (x tinterval);

CREATE TABLE example_unknown (x unknown);
WARNING:  column "x" has type "unknown"
```

В Apache Cloudberry™ те же самые запросы завершаются с ошибкой:

```sql
CREATE TABLE example_abstime (x abstime);
ERROR:  type "abstime" does not exist

CREATE TABLE example_reltime (x reltime);
ERROR:  type "reltime" does not exist

CREATE TABLE example_tinterval (x tinterval);
ERROR:  type "tinterval" does not exist

CREATE TABLE example_unknown (x unknown);
ERROR:  column "x" has pseudo-type unknown
```

**Как выявить**

Все типы данных полностью удалены — они недоступны для использования:

  * в SQL‑запросах;
  * при определении таблиц;
  * в функциях на языке PL/pgSQL.


Найти таблицы, использующие удаленные типы, можно следующим запросом:

  ```sql
  SELECT n.nspname, c.relname, a.attname, t.typname
  FROM pg_attribute a
      JOIN pg_class c ON c.oid = a.attrelid
      JOIN pg_namespace n ON n.oid = c.relnamespace
      JOIN pg_type t ON t.oid = a.atttypid
  WHERE t.typname IN ('abstime', 'reltime', 'tinterval', '_abstime', '_reltime', '_tinterval', 'unknown')
      AND a.attnum > 0
      AND NOT a.attisdropped;
  ```

Также отдельно стоит проверить определения пользовательских типов, представлений и PL/pgSQL-функций.

**Как исправить**

Заменить каждое использование устаревшего типа на актуальный аналог:

  * `abstime` → `timestamp` / `timestamptz`
  * `reltime` → `interval`
  * `tinterval` → пара значений `timestamp`/`timestamptz` или `text`
  * `unknown` → наиболее подходящий тип в зависимости от данных, либо `text`

### Запрет на использование префикса `pg_` в именах ролей {#pg-prefix}

Начиная с версии ядра PostgreSQL 9.6 префикс `pg_` зарезервирован для имен системных ролей и пользователей и больше недоступен.

В Greenplum® следующий запрос работает без ошибок:

```sql
CREATE ROLE pg_example;
```

В Apache Cloudberry™ такой запрос завершается с ошибкой:

```sql
CREATE ROLE pg_example;
ERROR:  role name "pg_example" is reserved
DETAIL:  Role names starting with "pg_" are reserved.
```

**Как выявить**

  ```sql
  SELECT rolname FROM pg_catalog.pg_roles WHERE rolname ~ '^pg_';
  ```

**Как исправить**

  ```sql
  ALTER ROLE pg_example RENAME TO another_example;
  ```
Исправление можно внести до обновления.

 
### Удаление расширений `tsearch2` и `timetravel` {#extenstion-deletion}

В Apache Cloudberry™ полностью удалены следующие расширения:

- `tsearch2`;
- `timetravel`.

**Как выявить**

Проверить, установлены ли эти расширения и используются ли они в вашей кодовой базе:

  ```sql
  SELECT extname, extversion
  FROM pg_extension
  WHERE extname IN ('tsearch2', 'timetravel');
  ```

**Как исправить**

Отказаться от использования удаленных расширений.

### Удалена поддержка таблиц, созданных с опцией `WITH OIDS` {#table-deletion}

В версиях ядра PostgreSQL новее 12 удалена поддержка таблиц,
созданных с опцией `WITH OIDS`.

В Greenplum® следующий запрос работает без ошибок:

```sql
CREATE TABLE example (value text) with oids;
```

В Apache Cloudberry™ тот же запрос завершается с ошибкой:

```sql
CREATE TABLE example (value text) with oids;
ERROR:  syntax error at or near "oids"
```

**Как выявить**

Найти все таблицы, определенные с опцией `WITH OIDS`, можно следующим запросом:

  ```sql
  SELECT n.nspname, c.relname
  FROM pg_class c
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE c.relhasoids
      AND n.nspname NOT IN ('pg_catalog', 'information_schema');
  ```

**Как исправить**

Для каждой найденной таблицы выполнить `ALTER TABLE ... SET WITHOUT OIDS;`. Если OID использовался как бизнес-ключ, дополнительно добавить столбец `bigserial` (или любой другой подходящий).

 
## Изменения в поведении функций и операторов {#function-change}

### Изменение поведения функций, возвращающих множества {#set-function-change}

Начиная с версии ядра PostgreSQL 10 изменилось поведение `Set Returning Functions` (например, `generate_series`, `unnest`, `regexp_split_to_table`, `json_each`, `json_array_elements`) в секции `SELECT`.

Разница видна на следующем примере.

Greenplum®:

```sql
SELECT 'example' AS value, generate_series(1, 3), generate_series(1, 2);
  value  | generate_series | generate_series
---------+-----------------+-----------------
 example |               1 |               1
 example |               2 |               2
 example |               3 |               1
 example |               1 |               2
 example |               2 |               1
 example |               3 |               2
(6 rows)
```

Apache Cloudberry™:

```sql
SELECT 'example' AS value, generate_series(1, 3), generate_series(1, 2);
  value  | generate_series | generate_series
---------+-----------------+-----------------
 example |               1 |               1
 example |               2 |               2
 example |               3 |
(3 rows)
```

**Как выявить**

Проверить кодовую базу приложения на использование `Set Returning Functions` в секции `SELECT`.

**Как исправить**

Заменить вызовы `Set Returning Functions` в секции `SELECT` на соответствующий `CROSS JOIN LATERAL`.

### Тип возвращаемого значения функции `extract()` изменен на `numeric` {#extract-type}

Начиная с версии ядра PostgreSQL 14 функция `extract()` возвращает значение типа `numeric`, а не с типом `double precision`.

Пример для Greenplum®:

```sql
SELECT pg_typeof(extract(epoch FROM now()));
     pg_typeof
------------------
 double precision
```

Пример для Apache Cloudberry™:

```sql
SELECT pg_typeof(extract(epoch FROM now()));
 pg_typeof
-----------
  numeric
```

Если приложение ожидает `double precision`, его поведение может стать непредсказуемым.

**Как выявить**

Проверить кодовую базу приложения на использование функции `extract()`.

**Как исправить**

Внести правки в приложение либо в проблемные запросы, добавив явное приведение типа через `::double precision`.

### Исправлено поведение функции `to_number()` для корректной обработки форматов {#to-number}

В Greenplum® функция `to_number()` «съедала» лишние символы:

```sql
SELECT to_number('1234', '9,999');
 to_number
-----------
       134
(1 row)
```

В Apache Cloudberry™ это поведение исправлено:

```sql
SELECT to_number('1234', '9,999');
 to_number
-----------
      1234
(1 row)
```

**Как выявить**

Проверить кодовую базу приложения на использование функции `to_number()` и возможные проблемы со «съеданием» лишних символов.

**Как исправить**

Адаптировать приложение к изменившемуся корректному поведению `to_number()`.

### Изменен порядок вычисления некоторых операторов {#operator-order-change}

В Apache Cloudberry™ по сравнению с Greenplum® изменен порядок вычисления операторов `<=`, `>=`, `<>`, `IS`, `NOT BETWEEN` и других составных операторов.

Например, в Greenplum® следующий запрос некорректен:

```sql
SELECT 1 <> 2 IS TRUE;
ERROR:  argument of IS TRUE must be type boolean, not type integer
```

Но в Apache Cloudberry™ запрос работает:

```sql
SELECT 1 <> 2 IS TRUE;
?column?
----------
t
(1 row)
```

**Как выявить**

Проверить кодовую базу приложения на наличие выражений с неоднозначным порядком вычисления операторов.

**Как исправить**

Явно задать порядок вычисления операторов с помощью скобок.

### Изменено поведение `SIMILAR TO` с `ESCAPE NULL` {#similar-to-escape-null}

Начиная с версии ядра PostgreSQL 13 изменилось поведение конструкции `SIMILAR TO ... ESCAPE NULL`.

Пример для Greenplum®:

```sql
SELECT 'abc' SIMILAR TO 'abc' ESCAPE NULL;
?column?
----------
t
(1 row)
```

Пример для Apache Cloudberry™:

```sql
SELECT 'abc' SIMILAR TO 'abc' ESCAPE NULL;
?column?
----------

(1 row)
```

**Как выявить**

Проверить кодовую базу приложения на использование конструкции `ESCAPE NULL`.

**Как исправить**

Заменить `ESCAPE NULL` на `ESCAPE <some value>`.

## Синтаксические изменения и удаленные конструкции {#syntax}

### Требование явного `ROW()` в `UPDATE` с ROW-конструкторами {#row-constructor}

Начиная с версии ядра PostgreSQL 10 при обновлении одной колонки через `ROW`-конструктор требуется явно указывать ключевое слово `ROW`.

В Greenplum® следующий запрос работает без ошибок:

```sql
CREATE TABLE example (value text);

INSERT INTO example (value) VALUES ('a');

-- этот запрос
UPDATE example SET (value) = (value || '_updated');
```

В Apache Cloudberry™ тот же запрос завершается с ошибкой:

```sql
CREATE TABLE example (value text);

INSERT INTO example (value) VALUES ('a');

-- этот запрос
UPDATE example SET (value) = (value || '_updated');
ERROR:  source for a multiple-column UPDATE item must be a sub-SELECT or ROW() expression
```

**Как выявить**

Проверить кодовую базу приложения на использование `ROW`-конструктора для одной колонки.

**Как исправить**

Изменить проблемные запросы так, чтобы они либо не использовали `ROW`-конструктор (например, `UPDATE ... SET col = expr`), либо явно указывали ключевое слово `ROW`: `UPDATE ... SET (col) = ROW(expr)`.

### Отсутствие поддержки триггеров уровня операторов {#unsupported-triggers}

В отличие от Greenplum®, Apache Cloudberry™ не поддерживает `statement-level triggers`.

Следующие запросы корректно работают в Greenplum®:

```sql
CREATE TABLE example (
    id bigserial,
    value text
) DISTRIBUTED BY (id);

CREATE OR REPLACE FUNCTION example_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger
    AFTER INSERT OR UPDATE ON example
    FOR EACH STATEMENT
    EXECUTE PROCEDURE example_trigger_func();
```

Но не работают в Apache Cloudberry™:

```sql
CREATE TABLE example (
    id bigserial,
    value text
) DISTRIBUTED BY (id);

CREATE OR REPLACE FUNCTION example_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger
    AFTER INSERT OR UPDATE ON example
    FOR EACH STATEMENT
    EXECUTE PROCEDURE example_trigger_func();

ERROR:  Triggers for statements are not yet supported
```

**Как выявить**

Найти все `statement-level triggers` можно следующим запросом:

  ```sql
  SELECT n.nspname, c.relname, tgname
  FROM pg_trigger t
      JOIN pg_class c ON t.tgrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE tgtype & 1 = 0 AND NOT tgisinternal;
  ```

**Как исправить**

Отказаться от `statement-level triggers`: вынести логику на сторону приложения либо использовать `row-level triggers`.

### Функции с `EXECUTE ON` должны возвращать множества (`SETOF`) {#execute-on-return-setof}

В Apache Cloudberry™ функции с атрибутами `EXECUTE ON ALL SEGMENTS`/`COORDINATOR`/`INITPLAN` теперь должны возвращать `SETOF`.

Корректный пример для Greenplum®:

```sql
CREATE OR REPLACE FUNCTION example_func()
RETURNS integer
AS $$
BEGIN
    RETURN 42;
END;
$$ LANGUAGE plpgsql
EXECUTE ON ALL SEGMENTS;
```

Перестает работать в Apache Cloudberry™:

```sql
CREATE OR REPLACE FUNCTION example_func()
RETURNS integer
AS $$
BEGIN
    RETURN 42;
END;
$$ LANGUAGE plpgsql
EXECUTE ON ALL SEGMENTS;

ERROR:  EXECUTE ON ALL SEGMENTS is only supported for set-returning functions
```

**Как выявить**

Найти функции с атрибутами `EXECUTE ON ALL SEGMENTS`/`COORDINATOR`/`INITPLAN`, которые не возвращают `SETOF`, можно следующим запросом:

  ```sql
  SELECT n.nspname, p.proname
  FROM pg_proc p
      JOIN pg_language l ON l.oid = p.prolang
      JOIN pg_type t ON t.oid = p.prorettype
      JOIN pg_namespace n ON n.oid = p.pronamespace
  WHERE NOT proretset
      AND proexeclocation IN ('s', 'm', 'i')
      AND l.lanname NOT IN ('internal')
      AND t.typname NOT IN ('record');
  ```

**Как исправить**

Пересоздать проблемные функции с `RETURNS SETOF ...` и `RETURN NEXT`.

### Удалена поддержка постфиксных операторов {#postfix-operator-deletion}

Начиная с версии ядра PostgreSQL 14 удалена поддержка постфиксных операторов — как системных, так и определенных пользователем.

В Greenplum® следующий запрос работает без ошибок:

```sql
SELECT 5! AS factorial;
 factorial
-----------
       120
```

В Apache Cloudberry™ тот же запрос завершается с ошибкой:

```sql
SELECT 5! AS factorial;
ERROR:  syntax error at or near "AS"
LINE 1: SELECT 5! AS factorial;
```

**Как выявить**

В Greenplum® есть только один системный постфиксный оператор — `!`. Но могут существовать и операторы, определенные пользователем. Полный список постфиксных операторов можно получить следующим запросом:

  ```sql
  SELECT o.oid, n.nspname, o.oprname, o.oid < 16384 AS is_system
  FROM pg_operator o
      JOIN pg_namespace n ON o.oprnamespace = n.oid
  WHERE o.oprright = 0;
  ```

**Как исправить**

* Заменить использование оператора `!` на явный вызов функции `factorial(...)`.
* Заменить пользовательские постфиксные операторы на префиксные либо на явный вызов соответствующих функций.

## Изменения в механизмах партиционирования {#partitioning-changes}

### Требование включения всех ключей партиционирования в уникальные индексы {#partition-key-in-unique-index}

В отличие от Greenplum®, в Apache Cloudberry™ уникальный индекс должен включать **все** `partition keys`.

Пример запроса, работающего в Greenplum®:

```sql
CREATE TABLE sales (
    id int NOT NULL,
    region text,
    amount decimal(10, 2)
)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
    (
        VALUES ('Asia'),
        VALUES ('Europe')
    );

INSERT INTO sales (id, region, amount)
VALUES
    (1, 'Asia', 100.00),
    (1, 'Europe', 150.00),
    (2, 'Asia', 200.00);

CREATE UNIQUE INDEX sales_id_idx ON sales (id);
```

Тот же запрос не работает в Apache Cloudberry™:

```sql
CREATE TABLE sales (
    id int NOT NULL,
    region text,
    amount decimal(10, 2)
)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
    (
        VALUES ('Asia'),
        VALUES ('Europe')
    );

INSERT INTO sales (id, region, amount)
VALUES
    (1, 'Asia', 100.00),
    (1, 'Europe', 150.00),
    (2, 'Asia', 200.00);

CREATE UNIQUE INDEX sales_id_idx ON sales (id);
ERROR:  unique constraint on partitioned table must include all partitioning columns
DETAIL:  UNIQUE constraint on table "sales" lacks column "region" which is part of the partition key.
```

**Как выявить**

Найти все уникальные индексы, не включающие **все** `partition keys`, можно следующим запросом:

  ```sql
  WITH partitions AS (
  SELECT DISTINCT n.nspname, c.relname, c.oid, p.paratts
  FROM pg_partition p
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  )
  SELECT p.nspname, p.relname, ir.relname AS indexname
  FROM pg_index i
      JOIN partitions p ON p.oid = i.indrelid
      JOIN pg_class ir ON ir.oid = i.indexrelid
  WHERE (i.indisunique OR i.indisprimary)
      AND NOT (p.paratts <@ i.indkey);
  ```

**Как исправить**

Пересоздать найденные индексы, добавив `partition keys`.

### Ограничение на списковое партиционирование по нескольким столбцам {#list-partitioning-limit}

В Apache Cloudberry™ `list partitioning` по нескольким столбцам реализуется через `subpartitioning`: стандартный синтаксис Apache Cloudberry™ предполагает один столбец или выражение на каждом уровне.

Ограничение связано с тем, что партиционирование на основе списков по нескольким столбцам (например, `PARTITION BY LIST (col1, col2)`) зачастую делает невозможным использование оптимизатора GPORCA.

Следующий пример работает для Greenplum®:

```sql
CREATE TABLE example (a int, b int, c int)
    PARTITION BY LIST (b, c)
    (
        DEFAULT PARTITION other
    );
```

Но не работает для Apache Cloudberry™:

```sql
CREATE TABLE example (a int, b int, c int)
    PARTITION BY LIST (b, c)
    (
        DEFAULT PARTITION other
    );
ERROR:  cannot use "list" partition strategy with more than one column
```

**Как выявить**

Найти таблицы с партиционированием на основе списков по нескольким столбцам можно следующим запросом:

  ```sql
  SELECT n.nspname, c.relname
  FROM pg_partition p
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE parkind = 'l'
      AND parnatts > 1;
  ```

**Как исправить**

В Apache Cloudberry™ для этого следует использовать `subpartitioning`:

  ```sql
  CREATE TABLE example (a int, b int, c int)
  PARTITION BY LIST (b)
      SUBPARTITION BY LIST (c)
      SUBPARTITION TEMPLATE (
          DEFAULT SUBPARTITION other_c
      )
      (
          DEFAULT PARTITION other
      );
  ```

### Удалена поддержка `FOR (RANK(...))` в DDL партиций {#for-rank-deletion}

В Apache Cloudberry™ не поддерживается конструкция `FOR (RANK(...))` при работе с партициями.

Рабочий пример для Greenplum®:

```sql
CREATE TABLE sales (
    id int,
    date date,
    amount decimal(10, 2)
)
WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
DISTRIBUTED BY (id)
PARTITION BY RANGE (date) (
    START ('2026-01-01') END ('2027-01-01') EVERY (INTERVAL '1 month')
);

ALTER TABLE sales
    ALTER PARTITION FOR (RANK(2))
    TRUNCATE PARTITION FOR (RANK(2));
```

Не работает в Apache Cloudberry™:

```sql
CREATE TABLE sales (
    id int,
    date date,
    amount decimal(10, 2)
)
WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
DISTRIBUTED BY (id)
PARTITION BY RANGE (date) (
    START ('2026-01-01') END ('2027-01-01') EVERY (INTERVAL '1 month')
);

ALTER TABLE sales
    ALTER PARTITION FOR (RANK(2))
    TRUNCATE PARTITION FOR (RANK(2));
ERROR:  addressing partition by RANK is no longer supported
HINT:  Use partition name or FOR (<partition key value>) instead.
```

**Как выявить**

Проверить кодовую базу приложения и скрипты на использование конструкции `FOR (RANK(...))`.

**Как исправить**

Заменить `FOR (RANK(...))` на `FOR (VALUE ...)` или `FOR VALUES`.

### Изменено наследование параметров хранения для AO-таблиц {#ao-tables}

Если AO-параметр для партиции не указан явно, поведение различается:

* в Greenplum® применяется значение по умолчанию;
* в Apache Cloudberry™ параметр наследуется от родительской таблицы.

Следующий запрос работает для Greenplum®:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    region text,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
        (
        PARTITION asia VALUES ('Asia')
            WITH (appendoptimized = true, compresslevel = 0),
        PARTITION europe VALUES ('Europe')
        );
```

Но не работает для Apache Cloudberry™:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    region text,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
        (
        PARTITION asia VALUES ('Asia')
            WITH (appendoptimized = true, compresslevel = 0),
        PARTITION europe VALUES ('Europe')
        );
ERROR:  compresstype "zstd" can't be used with compresslevel 0
```

**Как выявить**

Найти партиции, созданные без явных опций, можно следующим запросом:

  ```sql
  SELECT
      schemaname,
      tablename,
      partitionschemaname,
      partitiontablename,
      par.reloptions AS parent_options,
      c.reloptions AS child_options,
      po AS parent_option
  FROM pg_partitions p
      JOIN pg_class par ON par.oid = format('%s.%s', schemaname, tablename)::regclass
      JOIN pg_class c ON c.oid = format('%s.%s', partitionschemaname, partitiontablename)::regclass
      JOIN unnest(par.reloptions) po ON TRUE
      LEFT JOIN unnest(c.reloptions) co ON split_part(po, '=', 1) = split_part(co, '=', 1)
  WHERE co IS NULL;
  ```

**Как исправить**

Создать копию проблемной партиции с явно заданными опциями, перенести в нее данные и заменить исходную партицию обновленной.

### Ограничения на `EXCLUSIVE`/`INCLUSIVE` границы для типов `float`/`numeric`/`text` {#exclusive-inclusive-limit}

В отличие от Greenplum®, в Apache Cloudberry™ конструкции `START EXCLUSIVE`/`END INCLUSIVE` работают только для типов с оператором `+` (например, `integer` и `timestamp`), но не для `float`, `numeric` и `text`.

Корректный пример для Greenplum®:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true)
    DISTRIBUTED BY (id)
    PARTITION BY RANGE (amount)
        (
        START (0) EXCLUSIVE
            END (1000)
            EVERY (250)
        );
```

Не работает в Apache Cloudberry™:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true)
    DISTRIBUTED BY (id)
    PARTITION BY RANGE (amount)
        (
        START (0) EXCLUSIVE
            END (1000)
            EVERY (250)
        );
ERROR:  START EXCLUSIVE not supported for partition key data type: numeric
HINT:  Specify an inclusive START value and remove the EXCLUSIVE keyword
```

**Как выявить**

Найти таблицы с `START EXCLUSIVE`/`END INCLUSIVE` на неподдерживаемых типах можно следующим запросом:

  ```sql
  SELECT n.nspname, c.relname, t.typname, pr.parchildrelid::regclass
  FROM pg_partition p
      JOIN pg_partition_rule pr ON p.oid = pr.paroid
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
      JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = ANY(p.paratts)
      JOIN pg_type t ON t.oid = a.atttypid
  WHERE t.typname IN ('text', 'float8', 'float4', 'numeric')
      AND (NOT pr.parrangestartincl OR pr.parrangeendincl);
  ```

**Как исправить**

Пересоздать проблемные таблицы без `EXCLUSIVE`/`INCLUSIVE` на этих типах.

### Изменена система уровней партиционированных таблиц {#pg-partition-tree}

В Greenplum® непосредственные партиции (`immediate child`) имеют `pg_partition.parlevel = 0`. В Apache Cloudberry™ непосредственные партиции имеют `pg_partition_tree().level = 1` (представление `pg_partition` в Apache Cloudberry™ удалено, поэтому нужно использовать функцию `pg_partition_tree()`).

Это изменение может нарушить работу запросов, опирающихся на уровень партиций.

**Как выявить**

Проверить кодовую базу приложения и скрипты на использование уровней партиций.

**Как исправить**

Адаптировать кодовую базу приложения и скрипты с учетом изменения уровня партиций и удаления представления `pg_partition`. Вместо `pg_partition` следует использовать функцию `pg_partition_tree()` или представление `pg_partitioned_table`.

### Перемещены ограничения партиционирования из `pg_constraint` {#move-patition-pg-constraint}

В Greenplum® границы партиций отображаются как `CHECK CONSTRAINT` в системном представлении `pg_constraint`.

В Apache Cloudberry™ границы партиций больше не являются `CHECK CONSTRAINT` и не отображаются в `pg_constraint`. Аналогичную информацию теперь можно получить из `gp_toolkit.gp_partitions`.

**Как выявить**

Проверить кодовую базу приложения и скрипты на использование `pg_constraint` для работы с ограничениями партиционирования.

**Как исправить**

Использовать представление `gp_toolkit.gp_partitions` вместо `pg_constraint` для работы с ограничениями партиционирования.

## Изменения в системном каталоге и метаданных {#metadata-change}

### Удаление и переименование колонок в представлениях и таблицах системного каталога {#columns}

При переходе к Apache Cloudberry™ (вместе с обновлением ядра PostgreSQL и Greenplum®) были удалены или переименованы следующие колонки в представлениях и таблицах системного каталога:

| Старая колонка                                                             | Новая колонка                                                       |
|----------------------------------------------------------------------------|---------------------------------------------------------------------|
| `pg_class.relhasoids`                                                      | Удалено                                                             |
| `pg_class.relhaspkey`                                                      | `EXISTS (SELECT FROM pg_index WHERE indrelid=... AND indisprimary)` |
| `pg_class.relstorage`                                                      | `pg_class.relam`                                                    |
| `pg_proc.proisagg`                                                         | `pg_proc.prokind = 'a'`                                             |
| `pg_proc.proiswindow`                                                      | `pg_proc.prokind = 'w'`                                             |
| `pg_proc.protransform`                                                     | `pg_proc.prosupport`                                                |
| `pg_attrdef.adsrc`                                                         | `pg_get_expr(adbin, adrelid)`                                       |
| `pg_constraint.consrc`                                                     | `pg_get_constraintdef(oid)`                                         |
| `pg_stat_activity.waiting`                                                 | `wait_event_type`, `wait_event`                                     |
| `pg_am.*` (десятки колонок)                                                | API методов доступа значительно переработан. Простой замены нет.    |
| `gp_distributed_log.distributed_id`, `gp_distributed_xacts.distributed_id` | Удалены                                                             |
| `gp_stat_replication.*_location`                                           | Переименовано в `*_lsn`                                             |
| `information_schema.routines.result_cast_character_set_name`               | Переименовано в `result_cast_char_set_name`                         |

**Как выявить**

Проверить кодовую базу приложения на использование удаленных или переименованных столбцов.

**Как исправить**

Внести соответствующие правки в кодовую базу приложения.

### Удаление системных таблиц и представлений {#system-table-deletion}

В Apache Cloudberry™ по сравнению с Greenplum® полностью удалены следующие системные таблицы и представления:

* `pg_catalog.pg_partition`;
* `pg_catalog.pg_partition_columns`;
* `pg_catalog.pg_partition_encoding`;
* `pg_catalog.pg_partition_rule`;
* `pg_catalog.pg_partitions`;
* `pg_catalog.pg_partition_templates`;
* `pg_catalog.pg_stat_partition_operations`.

**Как выявить**

Проверить кодовую базу приложения на использование удаленных системных таблиц и представлений.

**Как исправить**

Внести соответствующие правки в кодовую базу приложения.
 
Для работы с партиционированными таблицами в Apache Cloudberry™ следует использовать представление `pg_partitioned_table` и функции `pg_partition_tree()`, `pg_partition_ancestors()`, `pg_partition_root()`.

### Удаление и переименование системных функций {#sysmtem-functions}

В Apache Cloudberry™ по сравнению с Greenplum® полностью удалены следующие системные функции:

* `pg_get_partition_def`, `pg_get_partition_rule_def`, `pg_get_partition_template_def`.
* `gp_elog`, `gp_fault_inject`, `gp_update_ao_master_stats`.

Функции семейства `pg_*_xlog*` переименованы по шаблону `pg_*_wal*` (например, `pg_switch_xlog()` → `pg_switch_wal()`).
Часть функций удалена.

**Как выявить**

Проверить кодовую базу приложения на использование удаленных и переименованных системных функций.

**Как исправить**

Внести соответствующие правки в кодовую базу приложения.

### Изменения в отображении метаданных последовательностей {#seq-name}

Начиная с версии ядра PostgreSQL 10 изменилось отображение метаданных последовательностей.
Запросы вида `SELECT * FROM <seq_name>` теперь возвращают только `last_value`, `log_cnt`, `is_called`. Остальные свойства доступны через `pg_sequence` или `pg_sequences`.

Пример для Greenplum®:

```sql
CREATE SEQUENCE example_seq
    START WITH 100
    INCREMENT BY 1;

SELECT * FROM example_seq;
 sequence_name    | last_value | start_value | increment_by |      max_value      | min_value | cache_value | log_cnt | is_cycled | is_called
------------------+------------+-------------+--------------+---------------------+-----------+-------------+---------+-----------+-----------
 example_seq      |        100 |         100 |            1 | 9223372036854775807 |         1 |           1 |       0 | f         | f
```

Пример для Apache Cloudberry™:

```sql
CREATE SEQUENCE example_seq
    START WITH 100
    INCREMENT BY 1;

SELECT * FROM example_seq;
 last_value | log_cnt | is_called
------------+---------+-----------
        100 |       0 | f

SELECT * FROM pg_sequence WHERE seqrelid = 'example_seq'::regclass;
 seqrelid | seqtypid | seqstart | seqincrement |       seqmax        | seqmin | seqcache | seqcycle
----------+----------+----------+--------------+---------------------+--------+----------+----------
    17186 |       20 |      100 |            1 | 9223372036854775807 |      1 |       20 | f

SELECT * FROM pg_sequences WHERE sequencename = 'example_seq';
 schemaname | sequencename    | sequenceowner | data_type | start_value | min_value |      max_value      | increment_by | cycle | cache_size | last_value
------------+-----------------+---------------+-----------+-------------+-----------+---------------------+--------------+-------+------------+------------
 public     | example_seq     | user1         | bigint    |         100 |         1 | 9223372036854775807 |            1 | f     |         20 |
```

**Как выявить**

Проверить кодовую базу приложения на использование запросов вида `SELECT * FROM <seq_name>` с полями, отличными от `last_value`, `log_cnt`, `is_called`.

**Как исправить**

Внести соответствующие правки в кодовую базу приложения, обращаясь к `pg_sequence` или `pg_sequences`.

### Изменение внутреннего представления внешних таблиц {#external-tables}

Внутри Apache Cloudberry™ внешние таблицы (`EXTERNAL TABLES`) представлены как `FOREIGN TABLES`. По сравнению с Greenplum® это дает следующие отличия:

* Системное представление `pg_tables` больше не показывает внешние таблицы.
* `pg_class.relkind` для внешних таблиц теперь имеет значение `'f'`, а не `'r'`.
* Системная таблица `pg_exttable` стала представлением.
* Изменился вывод `EXPLAIN`: вместо `External Scan` отображается `Foreign Scan`.

**Как выявить**

Проверить кодовую базу приложения и скрипты на обращения к метаданным внешних таблиц.

Список внешних таблиц можно получить следующим запросом:

  ```sql
  SELECT n.nspname, c.relname, c.relkind, e.urilocation, e.execlocation, e.fmttype, e.fmtopts
  FROM pg_exttable e
      JOIN pg_class c ON c.oid = e.reloid
      JOIN pg_namespace n ON n.oid = c.relnamespace;
  ```

**Как исправить**

Внести в кодовую базу приложения и скрипты правки в соответствии с изменениями.

### Схема `gp_toolkit` теперь поставляется в виде расширения {#gp-toolkit}

В Apache Cloudberry™, в отличие от Greenplum®, `gp_toolkit` поставляется в виде расширения.
С точки зрения установки ничего не меняется — при создании базы данных `gp_toolkit` подключается автоматически.

Удалены следующие представления:

* `gp_toolkit.gp_size_of_partition_and_indexes_disk`;
* `gp_toolkit.__gp_user_data_tables`.

Изменены сигнатуры следующих существующих функций:

* `gp_toolkit.__gp_aoseg*`;
* `gp_toolkit.__gp_aocsseg*`;
* `gp_dist_wait_status`;
* `gp_execution_segment`;
* `gp_request_fts_probe_scan`
* `gp_tablespace_segment_location`.

В существующих представлениях удалены следующие колонки:

* `gp_toolkit.gp_locks_on_resqueue.lorwaiting`;
* `gp_toolkit.gp_resgroup_config.cpu_rate_limit`;
* `gp_toolkit.gp_resgroup_config.memory_auditor`;
* `gp_toolkit.gp_resgroup_config.memory_shared_quota`;
* `gp_toolkit.gp_resgroup_config.memory_spill_ratio`;
* `gp_toolkit.gp_resgroup_status.cpu_usage`;
* `gp_toolkit.gp_resgroup_status.memory_usage`;
* `gp_toolkit.gp_resgroup_status_per_host.cpu`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_available`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_quota_available`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_quota_used`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_shared_available`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_shared_used`;
* `gp_toolkit.gp_resgroup_status_per_host.memory_used`;
* `gp_toolkit.gp_resgroup_status_per_host.rsgname`;
* `gp_toolkit.gp_resgroup_status_per_segment.cpu`;
* `gp_toolkit.gp_resgroup_status_per_segment.hostname`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_available`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_quota_available`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_quota_used`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_shared_available`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_shared_used`;
* `gp_toolkit.gp_resgroup_status_per_segment.memory_used`;
* `gp_toolkit.gp_resgroup_status_per_segment.rsgname`;
* `gp_toolkit.gp_resgroup_status.rsgname`;
* `gp_toolkit.__gp_user_tables.autrelstorage`.

**Как выявить**

Проверить кодовую базу приложения и скрипты на использование измененных или удаленных объектов.

**Как исправить**

Адаптировать кодовую базу приложения и скрипты: отказаться от удаленных объектов и учесть изменения в существующих.

## Изменения в конфигурации и управлении ресурсами {#config-updates}

### Удаление параметров конфигурации {#config-params}

В Apache Cloudberry™ по сравнению с Greenplum® полностью удалены следующие параметры конфигурации:

* `wal_keep_segments` (переименован в `wal_keep_size`);
* `memory_spill_ratio`;
* `gp_resource_group_memory_limit`;
* `gp_resource_group_enable_recalculate_query_mem`;
* `gp_resource_group_cpu_ceiling_enforcement`;
* `gp_enable_gpperfmon`;
* `gp_gpperfmon_send_interval`;
* `gpperfmon_log_alert_level`;
* `gpperfmon_port`;
* `gp_log_resqueue_priority_sleep_time`;
* `dev_opt_unsafe_truncate_in_subtransaction`;
* `gp_add_column_inherits_table_setting`;
* `gp_allow_rename_relation_without_lock`;
* `gp_count_host_segments_using_address`;
* `gp_eager_agg_distinct_pruning`;
* `gp_eager_one_phase_agg`;
* `gp_eager_preunique`;
* `gp_enable_exchange_default_partition`;
* `gp_enable_mk_sort`;
* `gp_enable_motion_mk_sort`;
* `gp_enable_sort_distinct`;
* `gp_ignore_window_exclude`;
* `gp_indexcheck_vacuum`;
* `gp_partitioning_dynamic_selection_log`;
* `gp_safefswritesize`;
* `gp_use_synchronize_seqscans_catalog_vacuum_full`;
* `optimizer_analyze_enable_merge_of_leaf_stats`;
* `optimizer_enable_dml_triggers`;
* `optimizer_enable_partial_index`;
* `optimizer_prune_unused_columns`.

**Как выявить**

Проверить кодовую базу приложения на использование перечисленных параметров конфигурации.

**Как исправить**

Внести соответствующие правки в кодовую базу приложения, отказавшись от удаленных параметров конфигурации.

### Изменение возможных значений параметра `password_encryption` {#password_encryption}

Начиная с версии ядра PostgreSQL 10 изменились тип параметра `password_encryption` и множество возможных значений.

В Greenplum® параметр имеет следующий тип и возможные значения:

```sql
SELECT vartype, enumvals FROM pg_settings WHERE name = 'password_encryption';
 vartype | enumvals
---------+----------
 bool    |
(1 row)
```

В Apache Cloudberry™ параметр имеет следующий тип и возможные значения:

```sql
SELECT vartype, enumvals FROM pg_settings WHERE name = 'password_encryption';
 vartype |      enumvals
---------+---------------------
 enum    | {md5,scram-sha-256}
(1 row)
```
**Как выявить**

Проверить кодовую базу приложений на использование параметра `password_encryption` и учесть изменения.

**Как исправить**

В местах использования параметра `password_encryption` заменить значение на `md5`. Значение `scram-sha-256` также допустимо, но в текущей версии сервиса поддерживается ограниченно.

Исправление можно внести только после обновления.

### Изменение значений параметров по умолчанию {#default-parameters}

В Apache Cloudberry™ по сравнению с Greenplum® изменены значения по умолчанию для следующих параметров:

| Параметр                       |    Greenplum® |           Apache Cloudberry™ |
|--------------------------------|------------:|---------------------:|
| `wal_level`                    | `archive` | `replica` |
| `autovacuum_vacuum_cost_delay` | `20ms` | `2ms` |
| `checkpoint_completion_target` | 0.5 | 0.9 |
| `extra_float_digits` | 0 | 1 |
| `gp_interconnect_address_type` | `wildcard` | `unicast` |
| `autovacuum` | `off` | `on` для `template0` |
| `optimizer_enable_orderedagg`  |       `off` |                 `on` |
| `vacuum_cost_page_miss`        |          10 |                    2 |

**Как выявить**

Большинство параметров являются системными и влияют на работу лишь косвенно. Особняком стоит `extra_float_digits` — он может влиять на результаты запросов.

**Как исправить**

В местах, где проявляется влияние нового значения `extra_float_digits`, явно задавать `extra_float_digits = 0` на уровне сессии или транзакции.

### Возможные изменения в планах исполнения запросов {#query-plan}

Apache Cloudberry™ содержит множество изменений и улучшений в оптимизаторе GPORCA, которые могут изменить план выполнения запроса. Запросы не «сломаются» логически, но могут начать исполняться иначе.

Что стоит учитывать:

* Появились новые параметры, влияющие на построение плана запроса:

  * `enable_partitionwise_aggregate`;
  * `enable_partitionwise_join`;
  * `enable_parallel`;
  * `enable_parallel_dedup_semi_join`;
  * `enable_parallel_hash`;
  * `enable_parallel_append`;
  * `enable_parallel_dedup_semi_reverse_join`;
  * `enable_parallel_semi_join`;
  * `jit`;
  * `jit_above_cost`;
  * `jit_dump_bitcode`;
  * `jit_expressions`;
  * `jit_inline_above_cost`;
  * `jit_optimize_above_cost`;
  * `jit_tuple_deforming`.

* GPORCA не поддерживает `multi-level partitioned tables`.

**Как выявить**

Снять baseline-планы для критических запросов до перехода на Apache Cloudberry™:

  ```sql
  EXPLAIN (ANALYZE, VERBOSE, COSTS, BUFFERS) <query>;
  ```

**Как исправить**

В зависимости от характера изменений плана и критичности — переписать проблемный запрос или настроить параметры.

### Расширения, вошедшие в ядро {#extenstions}

В Apache Cloudberry™ следующие расширения удалены, а их функциональность перенесена в ядро:

* `gp_parallel_retrieve_cursor`;
* `gp_array_agg`;
* `gp_percentile_agg`.

**Как выявить**

Проверить, установлены ли эти расширения и используются ли они в вашей кодовой базе:

  ```sql
  SELECT extname, extversion
  FROM pg_extension
  WHERE extname IN ('gp_parallel_retrieve_cursor', 'gp_array_agg', 'gp_percentile_agg');
  ```

**Как исправить**

При необходимости адаптируйте кодовую базу приложения и скрипты к работе со встроенной функциональностью.

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._