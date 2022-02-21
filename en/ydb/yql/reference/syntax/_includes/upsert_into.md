---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/upsert_into.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/upsert_into.md
---

# UPSERT INTO

Adds or updates multiple rows in a table based on primary key matching. Missing rows are added. For the existing rows, the values of the specified columns are updated, but the values of the other columns are preserved.


`UPSERT` and [`REPLACE`](../replace_into.md) are data modification operations that don't require a pre-fetch and run faster and cheaper than other operations because of that.

Column mapping when using `UPSERT INTO ... SELECT` is done by names. Use `AS` to fetch a column with the desired name in `SELECT`.

**Examples**

```yql
UPSERT INTO my_table
SELECT pk_column, data_column1, col24 as data_column3 FROM other_table  
```

```yql
UPSERT INTO my_table ( pk_column1, pk_column2, data_column2, data_column5 )
VALUES ( 1, 10, 'Some text', Date('2021-10-07')),
       ( 2, 10, 'Some text', Date('2021-10-08'))
```

