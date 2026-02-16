---
title: How to read and write data in {{ ydb-full-name }}
description: Follow this guide to learn how to read and write data.
---

# Reading and writing data

## Prerequisites {#prerequisite}

To run queries, you will need to create a [database](manage-databases.md) and a [table](schema.md#create-table) in it.

## SQL queries in the management console {#web-sql}

To query a database in SQL from the management console:
1. In the [management console]({{ link-console-main }}), select the folder containing your database.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Select your database from the list.
1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
1. Click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** and enter the query text. When making queries, you can use templates:
   * To use one of the standard templates, select it from the drop-down list to the right of the **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** button.
   * To populate a template with data from a specific table, click ![image](../../_assets/horizontal-ellipsis.svg) in the row with the table and select the template.
1. Click **{{ ui-key.yacloud.ydb.sql.button_run }}**.

## Insert and edit data {#change-data}

To insert data in {{ ydb-short-name }}, use the [REPLACE]({{ ydb.docs }}/yql/reference/syntax/replace_into), [UPSERT]({{ ydb.docs }}/yql/reference/syntax/upsert_into), and [INSERT]({{ ydb.docs }}/yql/reference/syntax/insert_into) statements.

REPLACE and UPSERT statements result in a blind write. With an INSERT statement, data is read before writing. This ensures that the primary key is unique.

We recommend using REPLACE and UPSERT statements to write and edit data.

A single REPLACE, UPSERT, or INSERT query can insert multiple rows into a table.

{% note warning %}

The YQL management console includes PRAGMA AutoCommit. This means that a COMMIT runs automatically after each query. For example, if you enter multiple statements (as shown in the example below) and run your query, a COMMIT will run automatically after it.

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

Once the `series`, `seasons`, and `episodes` tables are created, you can insert data into a table using the [REPLACE]({{ ydb.docs }}/yql/reference/syntax/replace_into) statement. The basic syntax is as follows:

```sql
REPLACE INTO <table_name> (<list_of_columns>) VALUES (<list_of_values_to_add>);
```

Use the [REPLACE]({{ ydb.docs }}/yql/reference/syntax/replace_into) statement to add a new row or change an existing one based on the specified primary key value. If a row with the specified primary key value does not exist, it will be created. If the row already exists, the column values of the existing row will be replaced with the new ones. *The values of columns not involved in the operation are set to their defaults.* This is the only difference from the UPSERT statement.

{% note info %}

A REPLACE statement results in a blind write. For data writes or updates, we recommend using the REPLACE or UPSERT statements.

{% endnote %}

Data added using the following code sample will be used further on in this section.

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

Use the [UPSERT]({{ ydb.docs }}/yql/reference/syntax/upsert_into) statement to add a new row or change an existing one based on a specified value of the primary key. If a row with the specified primary key value does not exist, it will be created. If the row already exists, the column values of the existing row will be replaced with the new ones. *However, the values of columns not involved in the operation remain unchanged. This is the only difference from the REPLACE statement.*

{% note info %}

An UPSERT statement results in a blind write. For data writes, we recommend using the REPLACE or UPSERT statements.

{% endnote %}

The code below inserts one row of data into the `episodes` table.

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

Use the [INSERT]({{ ydb.docs }}/yql/reference/syntax/insert_into) statement to insert one or multiple rows. If you try to insert a row into a table with an existing primary key value, {{ ydb-short-name }} will return the following error message: `Transaction rolled back due to constraint violation: insert_pk.`.

{% note info %}

With an INSERT statement, data is read before writing. This makes it less efficient than REPLACE and UPSERT statements. For data writes, we recommend using the REPLACE and UPSERT statements.

{% endnote %}

The code below inserts one row of data into the `episodes` table.

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

The [UPDATE]({{ ydb.docs }}/yql/reference/syntax/update) statement changes the column values for table rows filtered by the predicate in the WHERE clause. The basic syntax is as follows:

```sql
UPDATE <table_name> SET <column_1_name>=<new_column_1_value>, ... ,<column_N_name>=<new_column_N_value> WHERE <row_filtering_clause>;
```

UPDATE statements cannot change primary key values. Run the following UPDATE statement to change the value of the `title` column from _Test Episode_ to _Test Episode Updated_ for the episode with the `series_id = 2`, `season_id = 1`, and `episode_id = 3` column values.

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

The [DELETE]({{ ydb.docs }}/yql/reference/syntax/delete) statement deletes table rows filtered by the predicate in the WHERE clause. The code below removes the episode with the `series_id = 2`, `season_id = 5`, and `episode_id = 21` column values from the `episodes` table.

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

Use the [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) statement to read data from a table.

To query data from the `series` table, run the code below.

```sql
SELECT
  series_id,
  title AS series_title,
  CAST (release_date AS Date) AS release_date
FROM series;
```

You can use an asterisk to select all the columns in a table. To get the values of all columns from the `series` table, run the code below.

```sql
SELECT
  *
FROM series;
```

{% note info %}

For more information about querying data by secondary index, see [this YQL guide]({{ ydb.docs }}/yql/reference/syntax/select#secondary_index).

{% endnote %}

## Make a parameterized query {#param-queries}

Use parameterized queries to improve performance by reducing the frequency of compiling and recompiling your queries.

>Example
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