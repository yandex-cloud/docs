---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/byteat.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/byteat.md
---
## ByteAt {#byteat}

Getting the byte value inside a string at an index counted from the beginning of the string. If an invalid index is specified, `NULL` is returned.

Arguments:

1. String: `String` or `Utf8`.
2. Index: `Uint32`.

**Examples**
``` yql
SELECT
    ByteAt("foo", 0), -- 102
    ByteAt("foo", 1), -- 111
    ByteAt("foo", 9); -- NULL
```
