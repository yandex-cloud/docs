# Выборка данных из всех колонок

Задача: выбрать все колонки из таблицы.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
SELECT         -- выбрать данные

    *          -- выбрать все колонки из таблицы

FROM episodes; -- таблица, из которой нужно выбрать данные

COMMIT;
```

