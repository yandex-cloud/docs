# ROUND with precision parameter is not supported for double precision data type in {{ PG }}

`ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND`

The [ROUND](../../../datalens/function-ref/ROUND.md) function with precision parameter is not supported for double precision data type in {{ PG }} data source.

{{ datalens-short-name }} recognizes the `double precision` and `numeric` types from {{ PG }} as a `Fractional number`. Of these two types, the [ROUND](../../../datalens/function-ref/ROUND.md) function with the `precision` parameter supports only `numeric`.  To bring `double precision` back to the database level, use the [DB_CAST](../../../datalens/function-ref/DB_CAST.md) function.

Example:

```
ROUND(DB_CAST([your field]/1000000, 'numeric', 16, 8) [, precision ]), where 16 is the total number of digits in a fractional number, 8 is the number of decimal places in this number.
```
