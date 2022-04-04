---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/to_from_bytes.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/to_from_bytes.md
---
## ToBytes and FromBytes {#to-from-bytes}

Conversion of [primitive data types](../../../types/primitive.md) to a string with their binary representation and back. Numbers are represented in the [little endian](https://en.wikipedia.org/wiki/Endianness#Little-endian) format.

**Examples**
``` yql
SELECT
    ToBytes(123), -- "\u0001\u0000\u0000\u0000"
    FromBytes(
        "\xd2\x02\x96\x49\x00\x00\x00\x00",
        Uint64
    ); -- 1234567890ul
```
