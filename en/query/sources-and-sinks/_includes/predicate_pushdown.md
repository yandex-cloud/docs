{{ yq-full-name }} can transfer processing of request parts to the data source system. This means that filter expressions are provided through {{ yq-full-name }} directly to the database for processing; these are typically the query conditions specified in `WHERE`. This kind of processing is called `filter pushdown`.

Filter pushdown is possible when using:

|Description|Example|
|---|---|
|Filters like `IS NULL`/`IS NOT NULL`|`WHERE column1 IS NULL` or `WHERE column1 IS NOT NULL`|
|Logical conditions `OR`, `NOT`, or `AND` |`WHERE column IS NULL OR column2 is NOT NULL`|
|Conditions `=`, `<>`, `<`, `<=`, `>`, `>=` for comparison with other columns or constants |`WHERE column3 > column4 OR column5 <= 10`|

Supported data types for filter pushdown:
