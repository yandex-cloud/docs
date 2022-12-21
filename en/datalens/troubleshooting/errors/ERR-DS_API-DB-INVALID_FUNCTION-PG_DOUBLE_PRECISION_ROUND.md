# ROUND with precision parameter is not supported for double precision data type in {{ PG }}

`ERR.DS_API.DB.INVALID_FUNCTION.PG_DOUBLE_PRECISION_ROUND`

The [ROUND](../../../datalens/function-ref/ROUND.md) function with the `precision` parameter isn't supported for the `double precision` type of the {{ PG }} data source.

{{ datalens-short-name }} recognizes the `double precision` and `numeric` types from {{ PG }} as a `Fractional numbers`. Out of these two types, the ROUND function with the `precision` parameter only accepts the `numeric` type.  To cast `double precision` back to the database level, use [DB_CAST](../../../datalens/function-ref/DB_CAST.md).

Example:

```
ROUND(DB_CAST([your field]/1000000, 'numeric', 16, 8) [, precision ]), where 16 is the total count of digits in a fractional number, and 8 is the count of digits in its fractional part.
```
