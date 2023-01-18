# Reading and writing data

## Prerequisites {#prerequisite}

To run queries, you'll need to create a [database](manage-database.md) and [table](schema.md) in it.

## SQL queries in the management console {#web-sql}

To send an SQL query to a database from the management console:
1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
1. In the list of services, select **{{ ydb-name }}**.
1. Select the database from the list.
1. Go to the **Navigation** tab.
1. Click **SQL query** and enter the query text. When making queries, you can use the following templates:
   * To use one of the standard templates, select it from the drop-down list to the right of the **SQL query** button.
   * To populate a template with data from a specific table, click ![image](../../_assets/horizontal-ellipsis.svg) in the row next to the table and select a template.
1. Click **Run**.

## Insert and update data {#change-data}

To insert data into {{ ydb-short-name }}, use the [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %}, [UPSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/upsert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/upsert_into){% endif %}, and [INSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/insert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/insert_into){% endif %} statements.

When executing REPLACE and UPSERT statements, a blind write is performed. With an INSERT statement, data is read before writing. This ensures that the primary key is unique.

We recommend using REPLACE and UPSERT statements to write and modify data.

A single REPLACE, UPSERT, or INSERT query can insert multiple rows into a table.

{% note warning %}

The YQL management console includes PRAGMA AutoCommit. This means that COMMIT is automatically executed after each query. For example, if you enter multiple statements (as shown in the example below) and execute the query, COMMIT is run automatically after the query.

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

Once you create the ```series```, ```seasons```, and ```episodes``` tables, you can insert data into the table using the [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %} statement. Basic syntax:

```sql
REPLACE INTO table_name (column_list) VALUES (list_of_added_values);
```

The [REPLACE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/replace_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/replace_into){% endif %} statement is used to add a new or change an existing row at a given value of the primary key. If a row with the specified primary key value does not exist, it is created. If the row exists already, the column values of the existing row are replaced with the new values. *The values of columns not involved in the operation are set to their default values.* This is the only way the UPSERT statement is different.

{% note info %}

When performing a REPLACE operation, a blind write is performed. For write or change operations, we recommend using REPLACE and UPSERT statements.

{% endnote %}

Data added using the following code sample will be used later in this section.

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

The [UPSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/upsert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/upsert_into){% endif %} is used to add a new or change an existing row at a given value of the primary key. If a row with the specified primary key value does not exist, it is created. If the row exists already, the column values of the existing row are replaced with the new values. *However, the values of columns not involved in the operation are not changed. This is what makes it different from the REPLACE statement.*

{% note info %}

When making an UPSERT, a blind write is performed. For writing data, we recommend using REPLACE and UPSERT statements.

{% endnote %}

The code below inserts one row of data into the ```episodes``` table.

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

The [INSERT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/insert_into){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/insert_into){% endif %} statement is used to insert one or more rows. If you try to insert a row into a table with an existing primary key value, {{ ydb-short-name }} returns the error message ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note info %}

When an INSERT operation is executed, the data is read before it is written. This makes it less efficient than REPLACE and UPSERT operations. For writing data, we recommend using REPLACE and UPSERT operations.

{% endnote %}

The code below inserts one row of data into the ```episodes``` table.

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

The [UPDATE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/update){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/update){% endif %} statement changes the values of columns for the table rows filtered by the WHERE clause. Basic syntax:

```sql
UPDATE table_name SET column1_name=new_column1_value, ... ,columnN_name=new_columnN_value WHERE conditions_for_row_filter;
```

UPDATE statements can't change primary key values. Enter and execute the following UPDATE statement to change the value of the ```title``` column from "Test Episode" to "Test Episode Updated" for the episode with ```series_id = 2```, ```season_id = 1```, and ```episode_id = 3```.

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

The [DELETE]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/delete){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/delete){% endif %} statement deletes the rows from the table filtered by the WHERE clause. The code below removes an ```episode``` with ```series_id = 2```, ```season_id = 5```, and ```episode_id = 21``` from the episodes table.

```sql
DELETE
FROM episodes
WHERE
  series_id = 2
  AND season_id = 5
  AND episode_id = 21
;
```

## Query data using SELECT {#select}

To read data in the table, use the [SELECT]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %} statement.

To query data from the ```series``` table, execute the code shown below.

```sql
SELECT
  series_id,
  title AS series_title,
  CAST (release_date AS Date) AS release_date
FROM series;
```

You can use an asterisk to select all the columns in a table. To obtain the values of all columns from the ```series``` table, execute the code shown below.

```sql
SELECT
  *
FROM series;
```

{% note info %}

To learn more about querying data by a secondary index, [read the YQL documentation]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#secondary_index){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#secondary_index){% endif %}.

{% endnote %}

## Make a parameterized query {#param-queries}

Use parameterized queries to improve performance by reducing the frequency of compiling and recompiling your queries.

> Example
>
> ```sql
> DECLARE $seriesId AS Uint64;
> DECLARE $seasonId AS Uint64;
>
> $seriesId = 1;
> $seasonId = 2;
>
> SELECT sa.title AS season_title, sr.title AS series_title
> FROM seasons AS sa
> INNER JOIN series AS sr
> ON sa.series_id = sr.series_id
> WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
> ```
