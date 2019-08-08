# Alter table

Task: add new column into the table.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
-- add non-key column to the existing table
ALTER TABLE episodes ADD COLUMN viewers Uint64;

-- drop non-key column
ALTER TABLE episodes DROP COLUMN viewers;
```