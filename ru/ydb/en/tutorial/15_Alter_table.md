# Добавление новых колонок

Task: add new column into the table.

{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
-- add non-key column to the existing table
ALTER TABLE episodes ADD COLUMN viewers Uint64;

-- drop non-key column
-- ALTER TABLE episodes DROP COLUMN viewers;
```