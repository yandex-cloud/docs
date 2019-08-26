# Добавление новых колонок

Задача: 
1. Добавить новую колонку в таблицу,
2. Удалить добавленную колонку из таблицы.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

Добавить неключевую колонку в существующую таблицу:

```sql
ALTER TABLE episodes ADD COLUMN viewers Uint64;
```

Удалить добавленную колонку из таблицы:

```sql
ALTER TABLE episodes DROP COLUMN viewers;
```
