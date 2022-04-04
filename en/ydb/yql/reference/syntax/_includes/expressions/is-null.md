---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/is-null.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/is-null.md
---
## IS \[NOT\] NULL {#is-null}

Matching an empty value (`NULL`). Since `NULL` is a special value [equal to nothing](../../../types/optional.md#null_expr), the ordinary [comparison operators](#comparison-operators) can't be used to match it.

**Examples**

``` yql
SELECT key FROM my_table
WHERE value IS NOT NULL;
```
