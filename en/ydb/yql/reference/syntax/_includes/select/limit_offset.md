---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/select/limit_offset.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/select/limit_offset.md
---
## LIMIT and OFFSET {#limit-offset}

`LIMIT` limits the output to the specified number of rows. By default, the output is not restricted.

`OFFSET`: specifies the offset from the beginning (in rows). By default, it's zero.

**Examples**

```yql
SELECT key FROM my_table
LIMIT 7;
```

```yql
SELECT key FROM my_table
LIMIT 7 OFFSET 3;
```

```yql
SELECT key FROM my_table
LIMIT 3, 7; -- equivalent to the previous example
```

