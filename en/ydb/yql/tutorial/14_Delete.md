# Delete data

Task: delete data from table.

Fetches rows from table by the WHERE predicate (at the beginning of the transaction) and deletes them.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
DELETE
FROM episodes
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 12
;

COMMIT;

-- Let's take a look at the result.
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

-- YDB transaction doesn't see its own changes, and operates on the data
-- read on transaction start. It is impossible to execute UPDATE or DELETE on
-- the table, already changed within current transaction. UPDATE ON and
-- DELETE ON allow you to read, update and delete several rows from one table
-- within a single transaction.
--
$to_delete = (
    SELECT series_id, season_id, episode_id
    FROM episodes
    WHERE series_id = 1 AND season_id = 1 AND episode_id = 2
);

SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

DELETE FROM episodes ON
SELECT * FROM $to_delete;

COMMIT;

-- Let's take a look at the result.
SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

COMMIT;
```