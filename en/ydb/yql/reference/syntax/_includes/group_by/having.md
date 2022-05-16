---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/group_by/having.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/group_by/having.md
---
## HAVING {#having}

Filtering a `SELECT` based on the calculation results of [aggregate functions](../../../builtins/aggregation.md). The syntax is similar to [WHERE](../../select.md#where).

**Example**

```yql
SELECT
    key
FROM my_table
GROUP BY key
HAVING COUNT(value) > 100;
```

