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

Then, top-level aggregation will be computed with grouping by such chart dimensions as `[Region]` and `[Category]`, and the nested aggregation will use the `[Region]`, `[Category]`, and `[City]` dimensions.

For more information about using LOD expressions, see [{#T}](../../concepts/lod-aggregation.md).
