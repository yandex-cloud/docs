---
title: ERR.DS_API.FORMULA.VALIDATION.LOD.INVALID_TOPLEVEL_DIMENSIONS error
description: This page describes the ERR.DS_API.FORMULA.VALIDATION.LOD.INVALID_TOPLEVEL_DIMENSIONS error.
---

# Invalid top-level LOD dimension found in expression

`ERR.DS_API.FORMULA.VALIDATION.LOD.INVALID_TOPLEVEL_DIMENSIONS`

The error results from top-level aggregation containing dimensions not used in a chart.

For example, you cannot create the following measure in a chart grouped by `[Region]` and `[Category]`:

```
AVG([Sales] INCLUDE [City])
```

In this case the error occurs because the chart does not use the `[City]` dimension, which was added to the grouping with the help of `INCLUDE`.

To correct the error, change the expression for the top-level aggregation only to contain dimensions used in the chart. For example:

```
AVG(AVG([Sales] INCLUDE [City]))
```

The top-level aggregation will thus be calculated grouped by the chart's `[Region]` and `[Category]` dimensions, and the nested aggregation will use grouping by the `[Region]`, `[Category]`, and `[City]` dimensions (grouping by `[City]` is added to the nested function using `INCLUDE`).

The dimension to group by is specified inside the [aggregation function](../../../datalens/function-ref/aggregation-functions.md#syntax) using keywords, for example:

* `AVG(SUM([orders]) INCLUDE [date])`, where grouping by `[date]` is added to the top-level aggregation (the `INCLUDE` keyword applies to the `AVG` function).
* `AVG(SUM([orders] INCLUDE [date]))`, where grouping by `[date]` is added to the nested aggregation (the `INCLUDE` keyword applies to the `SUM` function).

For more information about using LOD expressions, see [{#T}](../../concepts/lod-aggregation.md).
