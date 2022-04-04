---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/window/row_number.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/window/row_number.md
---
## ROW_NUMBER {#row_number}

Row number within a [partition](../../../syntax/window.md#partition). No arguments.

**Examples**
``` yql
SELECT
    ROW_NUMBER() OVER w AS row_num
FROM my_table
WINDOW w AS (ORDER BY key);
```
