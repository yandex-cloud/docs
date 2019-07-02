# Выборка данных из всех колонок

Task: select all columns.

{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
SELECT -- the top level SELECT returns data to the client

    *  -- star symbol means "all columns";

FROM episodes;    -- short table name

COMMIT;
```