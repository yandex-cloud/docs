# Division by zero

`ERR.DS_API.DB.ZERO_DIVISION`

There was an error dividing by zero in the query.
The data source does not support dividing by zero.
Check your formulas and fix them.

For example, if this formula results in such an error
```
[A] / [B]
```

You can re-write it like this:

```
IF([B] != 0, [A] / [B], NULL)
```

Alternatively, you can use another numeric value instead of the `NULL`, depending on the desired result.

You can also use [DIV_SAFE](../../../datalens/function-ref/DIV_SAFE.md) and [FDIV_SAFE](../../../datalens/function-ref/FDIV_SAFE.md) functions that handle division by zero.
