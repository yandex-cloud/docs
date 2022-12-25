# Invalid top-level LOD dimension found in expression

`ERR.DS_API.FORMULA.VALIDATION.LOD.INVALID_TOPLEVEL_DIMENSIONS`

The error results from top-level aggregation containing dimensions not used in a chart.

For instance, a chart grouped by `[Region]` and `[Category]` cannot include the following metric:

```
AVG([Sales] INCLUDE [City])
```

The error in this case occurs because the `[City]` measurement (added to the grouping using `INCLUDE`) is not used in the chart.

To correct the error, change the expression for the top-level aggregation only to contain dimensions used in the chart. For example:

```
AVG(AVG([Sales] INCLUDE [City]))
```

This will cause top-level aggregation to be calculated with grouping by the `[Region]` and `[Category]` chart dimensions while nested aggregation will use the `[Region]`, `[Category]`, and `[City]` dimensions (grouping by `[City]` is added to the nested function using `INCLUDE`).

The dimension to group by is specified inside the [aggregation function](../../../datalens/function-ref/aggregation-functions.md#syntax) using keywords, for example:

* `AVG(SUM([orders]) INCLUDE [date])`: In this record, grouping by `[date]` is added to top-level aggregation (the `INCLUDE` keyword applies to the `AVG` function).
* `AVG(SUM([orders] INCLUDE [date]))`: In this record, grouping by `[date]` is added to the nested aggregation (the `INCLUDE` keyword applies to the `SUM` function).

For more information about using LOD expressions, see [{#T}](../../concepts/lod-aggregation.md).
