---
sourcePath: core/yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
sourcePath: yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
---

## TableRow, JoinTableRow {#tablerow}

Получение всей строки таблицы целиком в виде структуры. Аргументов нет. `JoinTableRow` в случае `JOIN`-ов всегда возвращает структуру с префиксами таблиц.

**Пример**
``` yql
SELECT TableRow() FROM my_table;
```
