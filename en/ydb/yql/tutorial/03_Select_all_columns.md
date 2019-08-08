# Select all columns

Task: select all columns.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
SELECT -- the top level SELECT returns data to the client

    *  -- star symbol means "all columns";

FROM episodes;    -- short table name

COMMIT;
```