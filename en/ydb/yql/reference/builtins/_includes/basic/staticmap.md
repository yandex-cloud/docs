---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/staticmap.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/staticmap.md
---

## StaticMap

Transforms a structure or tuple by applying a lambda function to each element.

Arguments:

* Structure or tuple.
* Lambda for processing elements.

Result: a structure or tuple with the same number and naming of elements as in the first argument, and with element data types determined by lambda results.

**Examples:**
``` yql
SELECT *
FROM (
    SELECT
        StaticMap(TableRow(), ($item) -> {
            return CAST($item AS String);
        })
    FROM my_table
) FLATTEN COLUMNS; -- converting all columns to rows
```

