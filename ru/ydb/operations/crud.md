# Чтение и запись данных

## Предварительные требования {#prerequisite}

Для выполнения запросов понадобится создать [базу данных](manage-database.md) и [таблицу](schema.md) в ней.

## SQL-запросы в консоли управления {#web-sql}

Чтобы отправить SQL-запрос к базе данных из консоли управления:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
1. В списке сервисов выберите **{{ ydb-name }}**.
1. Выберите базу из списка.
1. Перейдите на вкладку **Навигация**.
1. Нажмите кнопку **SQL-запрос** и введите текст запроса. При составлении запроса вы можете пользоваться шаблонами:
   * Чтобы воспользоваться одним из стандартных шаблонов, выберите его из выпадающего списка справа от кнопки **SQL-запрос**.
   * Чтобы подставить в шаблон данные определенной таблицы, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) в строке с нужной таблицей и выберите шаблон.
1. Нажмите кнопку **Выполнить**.

## Вставьте и измените данные {#change-data}

Для вставки данных в {{ ydb-short-name }} используются инструкции [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %}, [UPSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/upsert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/upsert_into){% endif %} и [INSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/insert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/insert_into){% endif %}.

При выполнении инструкций REPLACE и UPSERT осуществляется слепая запись. При выполнении инструкции INSERT перед операцией записи выполняется операция чтения данных. Это позволяет убедиться, что уникальность первичного ключа будет соблюдена.

Использование инструкций REPLACE и UPSERT предпочтительнее при операциях записи и изменения данных.

Одним запросом REPLACE, UPSERT или INSERT можно вставить в таблицу несколько строк.

{% note warning %}

В консоль управления YQL включена PRAGMA AutoCommit. Это означает, что после каждого запроса автоматически будет выполняться COMMIT. Например, если вы введете несколько выражений (как показано в примере ниже) и выполните запрос, после запроса автоматически будет выполнен COMMIT.

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

После создания таблиц ```series```, ```seasons``` и ```episodes``` можно вставить данные в таблицу с помощью инструкции [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %}. Базовый синтаксис:

```sql
REPLACE INTO имя_таблицы (список_столбцов) VALUES (список_добавляемых_значений);
```

Инструкция [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %} используется для добавления новой или изменения существующей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок, не участвующих в операции, устанавливаются в значения по умолчанию.* В этом заключается единственное отличие от инструкции UPSERT.

{% note info %}

При выполнении операции REPLACE осуществляется слепая запись. Для операций записи или изменения данных предпочтительнее использовать инструкции REPLACE или UPSERT.

{% endnote %}

Данные, добавленные с помощью следующего примера кода, будут использоваться далее в этом разделе.

```sql
REPLACE INTO series (series_id, title, release_date, series_info)
VALUES
  (
    1,
    "IT Crowd",
    CAST(Date("2006-02-03") AS Uint64),
    "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."
  ),
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

Инструкция [UPSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/upsert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/upsert_into){% endif %} используется для добавления новой или изменения существующей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок, не участвующих в операции, не изменяют свои значения. В этом заключается единственное отличие от инструкции REPLACE.*

{% note info %}

При выполнении операции UPSERT осуществляется слепая запись. Для записи предпочтительнее использовать инструкции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу ```episodes``` одну строчку с данными.

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

### INSERT {#insert}

Инструкция [INSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/insert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/insert_into){% endif %} используется для вставки одной или нескольких строк. При попытке вставить строку в таблицу, с уже существующим значением первичного ключа {{ ydb-short-name }} вернёт ошибку с сообщением ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note info %}

При выполнении операции INSERT перед записью осуществляется чтение данных. Это делает ее менее эффективной, чем операции REPLACE и UPSERT. Для записи предпочтительнее использовать операции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу ```episodes``` одну строчку с данными.

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

### UPDATE {#update}

Инструкция [UPDATE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/update){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/update){% endif %} изменяет значения колонок для строк таблицы, отфильтрованных по предикату из условия WHERE. Базовый синтаксис:

```sql
UPDATE имя_таблицы SET имя_столбца1=новое_значение_столбца1, ... ,имя_столбцаN=новое_значение_столбцаN WHERE условия_для_фильтра_строк;
```

Значения первичного ключа в рамках инструкции UPDATE не могут быть изменены. Введите и выполните следующую инструкцию UPDATE, чтобы изменить значение столбца ```title``` для эпизода со значениями столбцов ```series_id = 2```, ```season_id = 1```и ```episode_id = 3``` со значения "Test Episode" на значение "Test Episode Updated".

```sql
UPDATE episodes
SET title="Test Episode Updated"
WHERE
  series_id = 2
  AND season_id = 1
  AND episode_id = 3
;
```

### DELETE {#delete}

Инструкция [DELETE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/delete){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/delete){% endif %} удаляет строки таблицы, отфильтрованные по предикату из условия WHERE. Код, приведенный ниже, удалит из таблицы ```episodes``` эпизод со следующими значениями столбцов: ```series_id = 2```, ```season_id = 5```, и ```episode_id = 21```.

```sql
DELETE
FROM episodes
WHERE
  series_id = 2
  AND season_id = 5
  AND episode_id = 21
;
```

## Запросите данные при помощи SELECT {#select}

Для чтения данных в таблице используется инструкция [SELECT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}.

Чтобы запросить данные из таблицы ```series```, выполните код, представленный ниже.

```sql
SELECT
  series_id,
  title AS series_title,
  CAST (release_date AS Date) AS release_date
FROM series;
```

Чтобы выбрать все столбцы в таблице, можно использовать звездочку. Для того чтобы получить значения всех столбцов из таблицы ```series```, выполните код представленный ниже.

```sql
SELECT
  *
FROM series;
```

{% note info %}

Подробнее о том, как запросить данные по вторичному индексу, [читайте в документации YQL]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#secondary_index){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#secondary_index){% endif %}.

{% endnote %}

## Сделайте параметризированный запрос {#param-queries}

Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов.

>Пример
>
>```sql
>DECLARE $seriesId AS Uint64;
>DECLARE $seasonId AS Uint64;
>
>$seriesId = 1;
>$seasonId = 2;
>
>SELECT sa.title AS season_title, sr.title AS series_title
>FROM seasons AS sa
>INNER JOIN series AS sr
>ON sa.series_id = sr.series_id
>WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
>```