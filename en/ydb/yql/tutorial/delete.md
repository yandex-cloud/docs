# Deleting data

Delete data from the table using [DELETE](../reference/syntax/delete.md).

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
DELETE
FROM episodes
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 12
;

COMMIT;

-- See result:
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

-- YDB transaction doesn't see its own changes and operates on the data
-- read on transaction start. It is impossible to execute UPDATE or DELETE,
-- if the table was already changed within the current transaction. UPDATE ON and
-- DELETE ON let you read, update, and delete multiple rows from one table
-- within a single transaction.

$to_delete = (
    SELECT series_id, season_id, episode_id
    FROM episodes
    WHERE series_id = 1 AND season_id = 1 AND episode_id = 2
);

SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

DELETE FROM episodes ON
SELECT * FROM $to_delete;

COMMIT;

-- See result:
SELECT * FROM episodes WHERE series_id = 1 AND season_id = 1;

COMMIT;
```

