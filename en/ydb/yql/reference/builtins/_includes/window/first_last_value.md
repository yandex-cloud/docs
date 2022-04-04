---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/window/first_last_value.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/window/first_last_value.md
---
## FIRST_VALUE / LAST_VALUE

Access values from the first and last rows of the [window frame](../../../syntax/window.md#frame). The only argument is the expression that you need to access.

Optionally, `OVER` can be preceded by the additional modifier `IGNORE NULLS`. It changes the behavior of functions to the first or last __non-empty__ (i.e., non-`NULL`) value among the window frame rows. The antonym of this modifier is `RESPECT NULLS`: it's the default behavior that can be omitted.

**Examples**
``` yql
SELECT
   FIRST_VALUE(my_column) OVER w
FROM my_table
WINDOW w AS (ORDER BY key);
```

``` yql
SELECT
   LAST_VALUE(my_column) IGNORE NULLS OVER w
FROM my_table
WINDOW w AS (ORDER BY key);
```
