---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/as.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/as.md
---
## AS {#as}

Can be used in the following scenarios:

* Adding a short name (alias) for columns or tables within the query.
* Using named arguments in function calls.
* To specify the target type in the case of explicit type casting, see [CAST](#cast).

**Examples:**

```yql
SELECT key AS k FROM my_table;
```

```yql
SELECT t.key FROM my_table AS t;
```

```yql
SELECT
    MyFunction(key, 123 AS my_optional_arg)
FROM my_table;
```

