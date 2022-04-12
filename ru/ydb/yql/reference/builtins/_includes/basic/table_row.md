---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-core/builtins/_includes/basic/table_row.md
sourcePath: ru/ydb/yql/reference/yql-core/builtins/_includes/basic/table_row.md
---
## TableRow, JoinTableRow {#tablerow}

Получение всей строки таблицы целиком в виде структуры. Аргументов нет. `JoinTableRow` в случае `JOIN`-ов всегда возвращает структуру с префиксами таблиц.

**Пример**
``` yql
SELECT TableRow() FROM my_table;
```
