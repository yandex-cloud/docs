# Insert and modify data with REPLACE

[REPLACE](../../yql/reference/syntax/replace_into.md) is used to insert a new record or update an existing one by primary key value. If the row doesn't exist, it will be created. Otherwise, existing row's columns participating in the query will be filled with the new values, other columns will be filled with the default values.

The main difference between REPLACE and [UPSERT](../../yql/reference/syntax/upsert_into.md) is: columns that aren't participating in the query will be filled with the default values. REPLACE is more efficient than INSERT. While executing INSERT, {{ ydb-short-name }} makes read operation first to ensure that primary key value doesn't exist and then write operation. Contrary, while executing REPLACE {{ ydb-short-name }} makes only blind write (writing data without previously reading it in the same transaction).

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

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
    "Test Episode",
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