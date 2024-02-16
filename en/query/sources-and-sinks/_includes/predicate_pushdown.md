{{ yq-full-name }} can transfer processing of request parts to the data source system. This means that filter expressions are provided through {{ yq-full-name }} directly to the database for processing; these are typically the query conditions specified in `WHERE`. This kind of processing is called `filter pushdown`.

Filter pushdown is possible when using:

| Description | Example |
|---|---|
| Filters of the `IS NULL`/`IS NOT NULL` type | `WHERE column1 IS NULL` or `WHERE column1 IS NOT NULL` |
| `OR`, `NOT`, `AND` logical conditions | `WHERE column IS NULL OR column2 is NOT NULL` |
| `=`, `<>`, `<`, `<=`, `>`, `>=` comparison conditions with other columns or constants | `WHERE column3 > column4 OR column5 <= 10` |

Supported data types for filter pushdown:

| Data type {{ yq-full-name }} |
|----|
| `BOOL` |
| `INT8` |
| `UINT8` |
| `INT16` |
| `UINT16` |
| `INT32` |
| `UINT32` |
| `INT64` |
| `UINT64` |
| `FLOAT` |
| `DOUBLE` |
