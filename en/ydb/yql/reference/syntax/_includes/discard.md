---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/discard.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/discard.md
---
# DISCARD

Calculates [`SELECT`](../select.md) without returning the result neither to the client or table. 

It's good to combine it with [`Ensure`](../../builtins/basic.md#ensure) to check the final calculation result against the user's criteria.

**Examples**

```yql
DISCARD SELECT 1;
```

```yql
INSERT INTO result_table WITH TRUNCATE
SELECT * FROM
my_table
WHERE value % 2 == 0;

COMMIT;

DISCARD SELECT Ensure(
    0, -- will discard result anyway
    COUNT(*) > 1000,
    "Too small result table, got only " || CAST(COUNT(*) AS String) || " rows"
) FROM result_table;
```

