---
sourcePath: core/yql/reference/yql-docs-core-2/builtins/_includes/window/row_number.md
sourcePath: yql/reference/yql-docs-core-2/builtins/_includes/window/row_number.md
---

## ROW_NUMBER {#row_number}

Номер строки в рамках [раздела](../../../syntax/window.md#partition). Без аргументов.

**Примеры**
``` yql
SELECT
    ROW_NUMBER() OVER w AS row_num
FROM my_table
WINDOW w AS (ORDER BY key);
```
