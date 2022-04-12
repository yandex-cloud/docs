---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-core/builtins/_includes/window/aggregate.md
sourcePath: ru/ydb/yql/reference/yql-core/builtins/_includes/window/aggregate.md
---
## Агрегатные функции {#aggregate-functions}

Все [агрегатные функции](../../aggregation.md) также могут использоваться в роли оконных.
В этом случае на каждой строке оказывается результат агрегации, полученный на множестве строк из [рамки окна](../../../syntax/window.md#frame).

**Примеры:**
``` yql
SELECT
    SUM(int_column) OVER w1 AS running_total,
    SUM(int_column) OVER w2 AS total,
FROM my_table
WINDOW
    w1 AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
    w2 AS ();
```
