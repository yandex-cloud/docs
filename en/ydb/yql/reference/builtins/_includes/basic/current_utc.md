---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/current_utc.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/current_utc.md
---

## CurrentUtc... {#current-utc}

`CurrentUtcDate()`, `CurrentUtcDatetime()` and `CurrentUtcTimestamp()`: getting the current date and/or time in UTC. The result data type is specified at the end of the function name.

The arguments are optional and work same as [RANDOM](#random).

**Examples**
``` yql
SELECT CurrentUtcDate();
```
``` yql
SELECT CurrentUtcTimestamp(TableRow()) FROM my_table;
```