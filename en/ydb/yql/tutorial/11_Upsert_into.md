# Insert and modify data with UPSERT

[UPSERT](../../yql/reference/syntax/upsert_into.md) is used to insert a new record or update an existing one by primary
key value. If the row doesn't exist, it will be created.

Otherwise, existing row's columns participating in the query will be updated with the new values.

The main difference between UPSERT and [REPLACE](../../yql/reference/syntax/replace_into.md) is: columns that aren't participating in the query will be filled with their existent values. UPSERT is more efficient than INSERT. While executing INSERT, {{ ydb-short-name }} makes read operation first to ensure that primary
key value doesn't exist and then write operation. Contrary, while executing UPSERT {{ ydb-short-name }} makes only blind write.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
-- Basic usage of mutating operations.
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
    5,
    13,
    "Test Episode",
    CAST(Date("2018-08-27") AS Uint64)
)
;

COMMIT;

-- Let's take a look at the result.
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

COMMIT;
```