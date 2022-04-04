---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/table_row.md
---
## TableRow, JoinTableRow {#tablerow}

Getting the entire table row as a structure. No arguments. `JoinTableRow` in case of `JOIN` always returns a structure with table prefixes.

**Example**
``` yql
SELECT TableRow() FROM my_table;
```
