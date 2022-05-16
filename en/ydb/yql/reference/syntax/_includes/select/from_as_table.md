---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/select/from_as_table.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/select/from_as_table.md
---
## FROM AS_TABLE {#as-table}

Accessing named expressions as tables using the `AS_TABLE` function.

`AS_TABLE($variable)` lets you use the value of `$variable` as the data source for the query. In this case, the variable `$variable` must have the type `List<Struct<...>>`.

**Example**

```yql
$data = AsList(
    AsStruct(1u AS Key, "v1" AS Value),
    AsStruct(2u AS Key, "v2" AS Value),
    AsStruct(3u AS Key, "v3" AS Value));

SELECT Key, Value FROM AS_TABLE($data);
```

