---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/between.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/between.md
---
## BETWEEN {#between}

Checking whether a value is in a range. It's equivalent to two conditions with `>=` and `<=` (range boundaries are included). Can be used with the `NOT` prefix to support inversion.

**Examples**

``` yql
SELECT * FROM my_table
WHERE key BETWEEN 10 AND 20;
```
