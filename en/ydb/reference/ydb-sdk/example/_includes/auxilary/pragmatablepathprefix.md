---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-sdk/example/_includes/auxilary/pragmatablepathprefix.md
---
`PRAGMA TablePathPrefix` adds a specified prefix to the database table paths. It uses standard file system path concatenation: i.e., it supports parent folder referencing and requires no trailing slash. For example:

```sql
PRAGMA TablePathPrefix = "/cluster/database";
SELECT * FROM episodes;
```

For more information about PRAGMA YQL, see the [YQL documentation](../../../../../yql/reference/index.md).

