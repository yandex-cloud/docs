---
sourcePath: core/yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
sourcePath: yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
---

## TableRow{% if feature_join %}, JoinTableRow{% endif %} {#tablerow}

Получение всей строки таблицы целиком в виде структуры. Аргументов нет{% if feature_join %}. `JoinTableRow` в случае `JOIN`-ов всегда возвращает структуру с префиксами таблиц{% endif %}.

**Пример**
``` yql
SELECT TableRow() FROM my_table;
```
