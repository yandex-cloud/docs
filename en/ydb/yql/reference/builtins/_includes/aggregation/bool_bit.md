---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/bool_bit.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/bool_bit.md
---
## BOOL_AND, BOOL_OR and BOOL_XOR {#bool-and-or-xor}

Apply the relevant logical operation  (`AND`/`OR`/`XOR`) to all values in a Boolean column or expression.

These functions **don't skip** `NULL` during aggregation, with even one `NULL` turning the result into `NULL`. To skip `NULLs` during aggregation, you can use the functions `MIN`/`MAX` or `BIT_AND`/`BIT_OR`/`BIT_XOR`.

**Examples**

```yql
SELECT
  BOOL_AND(bool_column),
  BOOL_OR(bool_column),
  BOOL_XOR(bool_column)
FROM my_table;
```

## BIT_AND, BIT_OR and BIT_XOR {#bit-and-or-xor}

Apply the relevant bitwise operation to all values of a numeric column or expression.

**Examples**

```yql
SELECT
    BIT_XOR(unsigned_numeric_value)
FROM my_table;
```

