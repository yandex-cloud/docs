---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/bitops.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/bitops.md
---

## ...Bit {#bitops}

`TestBit()`, `ClearBit()`, `SetBit()` and `FlipBit()`: Test, clear, set, or flip a bit in an unsigned number using the specified bit sequence number.

Arguments:

1. An unsigned number that's subject to the operation. TestBit is also implemented for strings.
2. Number of the bit.

TestBit returns `true/false`. The other functions return a copy of their first argument with the corresponding conversion.

**Examples:**
``` yql
SELECT
    TestBit(1u, 0), -- true
    SetBit(8u, 0); -- 9
```
