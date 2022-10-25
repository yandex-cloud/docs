# Incompatible dimensions

`ERR.DS_API.FORMULA.VALIDATION.LOD.INCOMPATIBLE_DIMENSIONS`

The error results from aggregations at the same nesting level having different sets of dimensions.

For instance, a chart grouped by `[Region]` and `[Category]` cannot include the following metric:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [Order Date])
)
```

The `ANY([City] INCLUDE [City])` and `AVG([Sales] INCLUDE [Order Date])` aggregations are at the same nesting level (inside `ARG_MAX`). The first aggregation has the `[City]` dimension, the second — `[Order Date]`. In this case, the error results from there being no other aggregation with both of these dimensions.

To correct the error, modify the expression to have one of the nested aggregations include all the dimensions used in the other nested aggregations. For example:

```
ARG_MAX(
     ANY([City] INCLUDE [City]),
     AVG([Sales] INCLUDE [City],[Order Date])
)
```

{% if product == "yandex-cloud" %}For more information about using LOD expressions, see [{#T}](../../concepts/lod-aggregation.md).{% endif %}
