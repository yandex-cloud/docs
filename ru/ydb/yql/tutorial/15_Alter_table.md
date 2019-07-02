# Добавление новых колонок

Задача: добавить новую колонку в таблицу.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
-- добавить неключевую колонку в существующую таблицу
ALTER TABLE episodes ADD COLUMN viewers Uint64;

-- опустить неключевую колонку
ALTER TABLE episodes DROP COLUMN viewers;
```

