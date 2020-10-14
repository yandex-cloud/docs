# Работа с данными

В этом разделе описана работа с данными YDB при помощи языка [YQL](https://yql.yandex-team.ru/docs/ydb/). Вы узнаете как читать и изменять данные в таблицах. Так как этот раздел является введением в использование языка [YQL](https://yql.yandex-team.ru/docs/ydb/), в нем используются только базовые конструкции и малая часть параметров.

YQL запросы могут быть отправлены для выполнения в YDB следующими способами:

* из приложения, написанного с использованием YDB SDK для [C++](start_cpp.md), [Java](start_java.md), [Python](start_python.md);
* при помощи [YQL](https://yql.yandex-team.ru/) интерфейса;
* с помощью встроенного в [веб-интерфейс](https://ydb.yandex-team.ru) YQL Kit.

Для выполнения инструкций языка YQL в этом разделе будет использоваться встроенный в [веб-интерфейс](https://ydb.yandex-team.ru) YQL Kit.

![Open YQL Kit](../_assets/db_ui_open_yql_kit.png)

{% note info "Руководство" %}

Руководство по работе с данными YDB при помощи [YQL](https://yql.yandex-team.ru/docs/ydb/) можно пройти в веб-интерфейсе [https://yql.yandex-team.ru/Tutorial/](https://yql.yandex-team.ru/Tutorial/ydb_01_Create_demo_tables).

{% endnote %}

## Предварительные требования
Для выполнения запросов из этого раздела понадобится база данных и наличие в ней таблиц, созданных в листинге 1 раздела ["Работа со схемой"](start_scheme.md).

## Чтение и запись данных

{% note info "PRAGMA AutoCommit" %}

В веб-консоли YQL включена PRAGMA AutoCommit. Это означает, что после каждого запроса автоматически будет выполняться COMMIT. Например, если вы в веб-консоли YQL введете несколько выражений <br>```REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");```<br>```REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");```<br> и выполните это запрос, после этого запроса автоматически будет выполнен ```COMMIT```.

{% endnote %}

### Запись и изменение данных

Для вставки данных в YDB используются инструкции REPLACE, UPSERT, INSERT.
При выполнении инструкций REPLACE и UPSERT осуществляется слепая запись, в то время как при выполении инструкции INSERT перед операцией записи для того, чтобы убедиться что уникальность первичного ключа будет соблюдена, выполняется операция чтения данных.
Использование инструкций REPLACE и UPSERT предпочтительно при операциях записи и изменения данных.

{% note info "Вставка нескольких строк в одном запросе" %}

Одним запросом REPLACE, UPSERT или INSERT можно вставить в таблицу несколько строк.

{% endnote %}

#### REPLACE

После создания таблиц series, seasons и episodes можно вставить данные в таблицу с помощью инструкции REPLACE. Базовый синтаксис: REPLACE INTO, имя таблицы, список столбцов, VALUES, а затем список добавляемых значений.

Инструкция REPLACE используется для добавления новой или изменения существующей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. **При этом значения колонок, не участвующих в операции, устанавливаются в значения по умолчанию. В этом заключается единственное отличие от инструкции UPSERT.**

{% note info "REPLACE" %}

При выполнении запроса осуществляется слепая запись. Для операций записи или изменения данных рекомендуется использовать инструкции REPLACE или UPSERT.

{% endnote %}

Код приведенный ниже вставит в таблицы series, seasons и episodes данные, которые будут использоваться далее в этом разделе.

<small>Листинг 1</small>

```sql
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

#### UPSERT

Инструкция UPSERT используется для добавления новой или изменения существущей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. **При этом значения колонок, не участвующих в операции, не изменяют свои значения. В этом заключается единственное отличие от инструкции REPLACE.**

{% note info "UPSERT" %}

При выполнении запроса осуществляется слепая запись. Для записи рекомендуется использовать инструкции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу episodes одну строчку с данными.

<small>Листинг 2</small>

```sql
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

#### INSERT

Инструкция INSERT используется для вставки одной или нескольких строк. При попытке вставить строку в таблицу, с уже существующим значением первичного ключа, YDB вернёт ошибку с сообщением ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note warning "INSERT" %}

При выполнении операции INSERT перед записью осуществляется чтение данных. Это делает ее менее эффективной, чем операции REPLACE и UPSERT. Для записи рекомендуется использовать операции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу episodes одну строчку с данными.

<small>Листинг 3</small>

```sql
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

#### UPDATE

Инструкция UPDATE изменяет значения колонок для строк таблицы, отфильтрованных по предикату из условия WHERE. Базовый синтаксис: UPDATE  имя таблицы SET имя_столбца1=новое_значение_столбца1, ..., имя_столбцаN=новое_значение_столбцаN WHERE условия для фильтра строк.
Значения первичного ключа в рамках инструкции UPDATE не могут быть изменены. Введите и выполните следующую инструкцию UPDATE, чтобы изменить значение столбца ```title``` для эпизода с значениями столбцов series_id = 2, season_id = 1 episode_id = 3 со значения "Test Episode" на значение "Test Episode Updated".

<small>Листинг 4</small>

```sql
UPDATE episodes
SET title="Test Episode Updated"
WHERE
    series_id = 2
    AND season_id = 1
    AND episode_id = 3
;
```

#### DELETE

Инструкция DELETE удаляет строки таблицы, отфильтрованные по предикату из условия WHERE. Код приведенный ниже удалит из таблицы episodes эпизод со следующими значениями столбцов series_id = 2, season_id = 1 episode_id = 3.

<small>Листинг 5</small>

```sql
DELETE
FROM episodes
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 12
;
```

### Чтение данных при помощи инструкции SELECT

Для чтения данных в таблице используется инструкция SELECT.
Подробнее о синтаксисе инструкции SELECT написано в [документации по YQL](https://yql.yandex-team.ru/docs/ydb/syntax/select/).

Чтобы прочитать данные из таблицы series, выполните код представленный ниже.

<small>Листинг 6</small>

```sql
SELECT
    series_id,
    title AS series_title,
    DateTime::ToDate(DateTime::FromDays(release_date)) AS release_date
FROM series;
```

В интерфейсе отобразится результат выполнения запроса:

![Select from table](../_assets/ydb_example_select_table.png)

Чтобы выбрать все столбцы в таблице, можно использовать звездочку. Для того, чтобы прочитать значения всех столбцов из таблицы series,
выполните код представленный ниже.

<small>Листинг 7</small>

```sql
SELECT
    *
FROM series;
```

### Параметризованные запросы

Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов.

<small>Листинг 8</small>

```sql
DECLARE $seriesId AS Uint64;
DECLARE $seasonId AS Uint64;

SELECT sa.title AS season_title, sr.title AS series_title
FROM seasons AS sa
INNER JOIN series AS sr
ON sa.series_id = sr.series_id
WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
```

{% note info "COMMIT fast" %}

YDB использует механизм [оптимистичных блокировок](https://en.wikipedia.org/wiki/Optimistic_concurrency_control). Для того, чтобы блокировки транзакций реже инвалидировались с ошибкой `Transaction locks invalidated` следует использовать короткие транзакции.

{% endnote %}
