---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/into_result.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/into_result.md
---

# INTO RESULT

Lets you set a custom label for [SELECT](../select.md). It can't be used along with [DISCARD](../discard.md).

**Examples:**

```yql
SELECT 1 INTO RESULT foo;
```

```yql
SELECT * FROM
my_table
WHERE value % 2 == 0
INTO RESULT `Result name`;
```

