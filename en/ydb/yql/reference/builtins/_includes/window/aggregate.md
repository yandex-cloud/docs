---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/window/aggregate.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/window/aggregate.md
---

## Aggregate functions {#aggregate-functions}

All [aggregate functions](../../aggregation.md) can also be used as window functions.
In this case, each row includes an aggregation result obtained on a set of rows from the [window frame](../../../syntax/window.md#frame).

**Examples:**
``` yql
SELECT
    SUM(int_column) OVER w1 AS running_total,
    SUM(int_column) OVER w2 AS total,
FROM my_table
WINDOW
    w1 AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
    w2 AS ();
```
