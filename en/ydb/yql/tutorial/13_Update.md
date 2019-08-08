# Update data

Task: update data in rows.

[UPDATE](../../yql/reference/syntax/update.md) fetches rows from table by the WHERE predicate (at the beginning of the transaction) and executes UPSERT. UPDATE can't change primary key value.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
UPDATE episodes
SET title="test Episode 2"
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 12
;

COMMIT;

-- Let's take a look at the result.
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

-- YDB transaction doesn't see it's own changes, and operates on the data
-- read on transaction start. It is impossible to execute UPDATE or DELETE on
-- the table, already changed within current transaction. UPDATE ON and
-- DELETE ON allows you to read, update and delete several rows from one table
-- within a single transaction.
--
$to_update = (
    SELECT series_id,
           season_id,
           episode_id,
           Utf8("Yesterday's Jam UPDATED") AS title
    FROM episodes
    WHERE series_id = 1 AND season_id = 1 AND episode_id = 1
);

SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

UPDATE episodes ON
SELECT * FROM $to_update;

COMMIT;

-- Let's take a look at the result.
SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

COMMIT;
```