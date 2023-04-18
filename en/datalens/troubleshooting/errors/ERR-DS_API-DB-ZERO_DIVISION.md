# Division by zero

`ERR.DS_API.DB.ZERO_DIVISION`

An error occurred when dividing by zero in a query.
The data source does not support dividing by zero.
Check your formulas and fix them.

For example, if the error was caused by this formula:
```
[A] / [B]
```

You can rewrite it as follows:

```
IF([B] != 0, [A] / [B], NULL)
```

Alternatively, you can use another numeric value instead of `NULL`, depending on the desired result.

You can also use the [DIV_SAFE](../../../datalens/function-ref/DIV_SAFE.md) and [FDIV_SAFE](../../../datalens/function-ref/FDIV_SAFE.md) functions that can handle division by zero.
