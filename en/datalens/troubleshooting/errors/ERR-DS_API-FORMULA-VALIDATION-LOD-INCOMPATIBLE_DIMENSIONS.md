---
title: ERR.DS_API.FORMULA.VALIDATION.LOD.INCOMPATIBLE_DIMENSIONS error
description: This page describes the ERR.DS_API.FORMULA.VALIDATION.LOD.INCOMPATIBLE_DIMENSIONS error.
---

# Incompatible dimensions

`ERR.DS_API.FORMULA.VALIDATION.LOD.INCOMPATIBLE_DIMENSIONS`

The error is there because aggregations at the same nesting level have different sets of dimensions.

For example, you cannot create the following measure in a chart grouped by `[Region]` and `[Category]`:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [Order Date])
)
```

The `ANY([City] INCLUDE [City])` and `AVG([Sales] INCLUDE [Order Date])` aggregations are at the same nesting level (inside `ARG_MAX`). The first aggregation has the `[City]` dimension; the second one, `[Order Date]`. In this case, the error results from there being no other aggregation with both of these dimensions.

To correct the error, modify the expression to have one of the nested aggregations include all the dimensions used in the other nested aggregations. For example:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [City],[Order Date])
)
```

For more information about using LOD expressions, see [{#T}](../../concepts/lod-aggregation.md).
