# Чтение и запись данных

{% if audience == "internal" %}

Запросы YQL могут быть отправлены для выполнения в YDB следующими способами:

* из приложения, написанного с использованием YDB SDK для [C++](start_cpp.md), [Java](start_java.md), [Python](start_python.md);
* при помощи [YQL](https://yql.yandex-team.ru/) интерфейса;
* с помощью встроенного в [консоль управления](https://ydb.yandex-team.ru) YQL Kit.

Для выполнения инструкций языка YQL в этом разделе будет использоваться встроенный в [веб-интерфейс](https://ydb.yandex-team.ru) YQL Kit.

![Open YQL Kit](../_assets/db_ui_open_yql_kit.png)

{% note info %}

Туториал по работе с данными YDB при помощи [YQL](https://yql.yandex-team.ru/docs/ydb/) можно пройти в [консоли управления](https://yql.yandex-team.ru/Tutorial/ydb_01_Create_demo_tables).

{% endnote %}

{% else if audience == external %}

Запросы YQL могут быть отправлены для выполнения в YDB следующими способами:

* из консоли управления;
* из приложения, написанного с использованием YDB SDK для Java, [Python](https://github.com/yandex-cloud/ydb-python-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk).

Для выполнения инструкций языка YQL в этом разделе будет использоваться консоль управления.

{% endif %}

## Предварительные требования {#prerequisite}

Для выполнения запросов понадобится [база данных](create_manage_database.md) и [схема](schema.md).

## Вставьте и измените данные {#change-data}

Для вставки данных в {{ ydb-short-name }} используются инструкции [REPLACE](../yql/reference/syntax/replace.md), [UPSERT](../yql/reference/syntax/upsert.md) и [INSERT](../yql/reference/syntax/insert.md).

При выполнении инструкций REPLACE и UPSERT осуществляется слепая запись. При выполениии инструкции INSERT перед операцией записи выполняется операция чтения данных. Это позволяет убедиться, что уникальность первичного ключа будет соблюдена.

Использование инструкций REPLACE и UPSERT предпочтительно при операциях записи и изменения данных.

Одним запросом REPLACE, UPSERT или INSERT можно вставить в таблицу несколько строк.

{% note important %}

В консоль управления YQL включена PRAGMA AutoCommit. Это означает, что после каждого запроса автоматически будет выполняться COMMIT. Например, если вы введете несколько выражений (как показано в примере ниже) и выполните запрос, после запроса автоматически будет выполнен СOMMIT.
```yql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

После создания таблиц *series*, *seasons* и *episodes* можно вставить данные в таблицу с помощью инструкции [REPLACE](../yql/reference/syntax/replace.md). Базовый синтаксис:

```yql
REPLACE INTO, имя_таблицы, список_столбцов, VALUES, список_добавляемых_значений
```

Инструкция REPLACE используется для добавления новой или изменения существущей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок не участвующих в операции устанавливаются в значения по умолчанию. В этом заключается единственное отличие от инструкции UPSERT.*

{% note info %}

При выполнении запроса осуществляется слепая запись. Для операций записи или изменения данных рекомендуется использовать инструкции REPLACE или UPSERT.

{% endnote %}

Данные, добавленные с помощью следующего примера кода, будут использоваться далее в этом разделе.

```yql
REPLACE INTO series (series_id, title, release_date, series_info)
VALUES
    (
        1,
        "IT Crowd",
        CAST(Date("2006-02-03") AS Uint64),
        "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."),
    (
        2,
        "Silicon Valley",
        CAST(Date("2014-04-06") AS Uint64),
        "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."
    )
    ;

REPLACE INTO seasons (series_id, season_id, title, first_aired, last_aired)
VALUES
    (1, 1, "Season 1", CAST(Date("2006-02-03") AS Uint64), CAST(Date("2006-03-03") AS Uint64)),
    (1, 2, "Season 2", CAST(Date("2007-08-24") AS Uint64), CAST(Date("2007-09-28") AS Uint64)),
    (2, 1, "Season 1", CAST(Date("2014-04-06") AS Uint64), CAST(Date("2014-06-01") AS Uint64)),
    (2, 2, "Season 2", CAST(Date("2015-04-12") AS Uint64), CAST(Date("2015-06-14") AS Uint64))
;

REPLACE INTO episodes (series_id, season_id, episode_id, title, air_date)
VALUES
    (1, 1, 1, "Yesterday's Jam", CAST(Date("2006-02-03") AS Uint64)),
    (1, 1, 2, "Calamity Jen", CAST(Date("2006-02-03") AS Uint64)),
    (2, 1, 1, "Minimum Viable Product", CAST(Date("2014-04-06") AS Uint64)),
    (2, 1, 2, "The Cap Table", CAST(Date("2014-04-13") AS Uint64))
;
```

### UPSERT {#upsert}

Инструкция [UPSERT](../yql/reference/syntax/upsert.md) используется для добавления новой или изменения существущей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок не участвующих в операции не изменяют свои значения. В этом заключается единственное отличие от инструкции REPLACE.*

{% note info %}

При выполнении запроса осуществляется слепая запись. Для записи рекомендуется использовать инструкции REPLACE или UPSERT.

{% endnote %}

Код приведенный ниже вставит в таблицу *episodes* одну строчку с данными.

```yql
UPSERT INTO episodes
(
    series_id,
    season_id,
    episode_id,
    title,
    air_date
)
VALUES
(
    2,
    1,
    3,
    "Test Episode",
    CAST(Date("2018-08-27") AS Uint64)
)
;
```

### INSERT {#insert}

Инструкция INSERT используется для вставки одной или нескольких строк. При попытке вставить строку в таблицу с уже существующим значением первичного ключа, {{ ydb-short-name }} вернёт ошибку с сообщением ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note info %}

При выполнении операции INSERT перед записью осуществляется чтение данных. Это делает ее менее эффективной, чем операции REPLACE и UPSERT. Для записи рекомендуется использовать операции REPLACE или UPSERT.

{% endnote %}

Код приведенный ниже вставит в таблицу *episodes* одну строчку с данными.

```yql
INSERT INTO episodes
(
    series_id,
    season_id,
    episode_id,
    title,
    air_date
)
VALUES
(
    2,
    5,
    21,
    "Test 21",
    CAST(Date("2018-08-27") AS Uint64)
)
;
```

### UPDATE {#update}

Инструкция [UPDATE](../yql/reference/syntax/update.md) изменяет значения колонок для строк таблицы, отфильтрованных по предикату из условия WHERE. Базовый синтаксис:

```yql
UPDATE имя_таблицы SET имя_столбца1=новое_значение_столбца1, ...,имя_столбцаN=новое_значение_столбцаN WHERE условия_для_фильтра_строк
```

Значения первичного ключа в рамках инструкции UPDATE не могут быть изменены. Введите и выполните следующую инструкцию UPDATE, чтобы изменить значение столбца ```title``` для эпизода с значениями столбцов ```series_id = 2```, ```season_id = 1```и ```episode_id = 3``` со значения "Test Episode" на значение "Test Episode Updated".

```yql
UPDATE episodes
SET title="Test Episode Updated"
WHERE
    series_id = 2
    AND season_id = 1
    AND episode_id = 3
;
```

### DELETE {#delete}

Инструкция DELETE удаляет строки таблицы, отфильтрованные по предикату из условия WHERE. Код приведенный ниже удалит из таблицы *episodes* эпизод со следующими значениями столбцов ```series_id = 2```, ```season_id = 1```, и ```episode_id = 3```.

```yql
DELETE
FROM episodes
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 12
;
```

## Запросите данные при помощи SELECT {#select}

Для чтения данных в таблице используется инструкция [SELECT](../yql/reference/syntax/select.md).

Чтобы запросить данные из таблицы *series*, выполните код представленный ниже.

```yql
SELECT
    series_id,
    title AS series_title,
    DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
FROM series;
```

{% if audience == "internal" %}

В интерфейсе отобразится результат выполнения запроса:

![Select from table](../_assets/ydb_example_select_table.png)

{% endif %}

Чтобы выбрать все столбцы в таблице, можно использовать звездочку. Для того, чтобы получить значения всех столбцов из таблицы *series*,
выполните код представленный ниже.

```yql
SELECT
    *
FROM series;
```

## Запросите данные по вторичному индексу {#si-select}

{% include [select_by_secondary_index](../_includes/select_by_secondary_index.md) %}

## Сделайте параметризированный запрос {#param-queries}

Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов.

```yql
DECLARE $seriesId AS Uint64;
DECLARE $seasonId AS Uint64;

SELECT sa.title AS season_title, sr.title AS series_title
FROM seasons AS sa
INNER JOIN series AS sr
ON sa.series_id = sr.series_id
WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
```

{% note info %}

YDB использует механизм [оптимистичных блокировок](https://en.wikipedia.org/wiki/Optimistic_concurrency_control). Для того, чтобы блокировки транзакций реже инвалидировались с ошибкой `Transaction locks invalidated` следует использовать короткие транзакции.

{% endnote %}
