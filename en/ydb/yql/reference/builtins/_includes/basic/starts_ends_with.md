---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/starts_ends_with.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/starts_ends_with.md
---

## StartsWith, EndsWith {#starts_ends_with}

Checking for a prefix or suffix in a string.

Required arguments:

* Source string;
* The substring being searched for.

The arguments can be of the `String` or `Utf8` type and can be optional.

**Examples**
``` yql
SELECT StartsWith("abc_efg", "abc") AND EndsWith("abc_efg", "efg"); -- true
```
``` yql
SELECT StartsWith("abc_efg", "efg") OR EndsWith("abc_efg", "abc"); -- false
```
``` yql
SELECT StartsWith("abcd", NULL); -- null
```
``` yql
SELECT EndsWith(NULL, Utf8("")); -- null
```
