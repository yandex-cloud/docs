# Вставка и модификация данных с помощью REPLACE

[REPLACE](../../yql/reference/syntax/replace_into.md) is used to insert a new record or update an existing one by primary
key value. If the row doesn't exist, it will be created.
Otherwise, existing row's columns participating in the query will be
populated with the new values, other columns will be populated with the
default values.
The main difference between REPLACE and [UPSERT](../../yql/reference/syntax/upsert_into.md) is: columns that aren't
participating in the query will be populated with the default values.
REPLACE is more efficient than INSERT.
While executing INSERT, {{ ydb-short-name }} makes read operation first to ensure that primary
key value doesn't exist and then write operation.
Contrary, while executing REPLACE {{ ydb-short-name }} makes only blind write
(writing data without previously reading it in the same transaction).


{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
REPLACE INTO episodes
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
    12,
    "Test Episode !!!",
    CAST(Date("2018-08-27") AS Uint64)
)
;

-- COMMIT transaction control call should be used to finish current mutating
-- transaction and make previous data modifications visible to the next SELECT
-- statement.
COMMIT;

-- Let's take a look at the row replaced in the transaction above.
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

COMMIT;
```