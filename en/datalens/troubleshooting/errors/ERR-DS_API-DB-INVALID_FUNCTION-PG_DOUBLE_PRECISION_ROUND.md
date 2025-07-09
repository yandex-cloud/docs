---
title: ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND error
description: This page describes the ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND error.
---

# ROUND with precision parameter is not supported for double precision data type in {{ PG }}

`ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND`

The [ROUND](../../../datalens/function-ref/ROUND.md) function with the `precision` parameter is not supported for the `double precision` type of {{ PG }} data source.

{{ datalens-short-name }} recognizes {{ PG }}'s `double precision` and `numeric` types as a `Fractional number`. Out of these two types, the ROUND function with the `precision` parameter only supports `numeric`. To get `double precision` back to the database level, use another function: [DB_CAST](../../../datalens/function-ref/DB_CAST.md).

Here is an example:

```
ROUND(DB_CAST([your field]/1000000, 'numeric', 16, 8) [, precision ]), where 16 is the total number of digits in the fractional number, and 8 is its count of decimal places.
```
