---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/histogram.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/histogram.md
---
## HISTOGRAM {#histogram}

Plotting an approximate histogram based on a numeric expression with automatic selection of buckets.

[Auxiliary functions](../../../udf/list/histogram.md)

### Basic settings

You can limit the number of buckets using an optional argument. The default value is 100. Keep in mind that added accuracy costs you more computing resources and may negatively affect the query execution time. In extreme cases, it may affect your query success.

### Support for weights

You can specify a "weight" for each value used in the histogram. To do this, pass to the aggregate function the second argument with an expression for calculating the weight. The weight of `1.0` is always used by default. If you use non-standard weights, you may also use the third argument to limit the number of buckets.

If you pass two arguments, the meaning of the second argument is determined by its type (if it's an integer literal, it limits the number of buckets, otherwise it's used as a weight).


### If you need an accurate histogram

1. You can use the aggregate functions described below with fixed bucket grids: [LinearHistogram](#linearhistogram) or [LogarithmicHistogram](#logarithmichistogram).
2. You can calculate the bucket number for each row and apply to it [GROUP BY](../../../syntax/group_by.md).

When you use [aggregation factories](../../basic.md#aggregationfactory), a `Tuple` containing a value and a weight is passed as the first [AGGREGATE_BY](#aggregateby) argument.

**Examples**

```yql
SELECT
    HISTOGRAM(numeric_column)
FROM my_table;
```

```yql
SELECT
    Histogram::Print(
        HISTOGRAM(numeric_column, 10),
        50
    )
FROM my_table;
```

```yql
$hist_factory = AggregationFactory("HISTOGRAM");

SELECT
    AGGREGATE_BY(AsTuple(numeric_column, 1.0), $hist_factory)
FROM my_table;
```

## LinearHistogram, LogarithmicHistogram, and LogHistogram {#linearhistogram}

Plotting a histogram based on an explicitly specified fixed bucket scale.

Arguments:

1. Expression used to plot the histogram. All the following arguments are optional.
2. Spacing between the `LinearHistogram` buckets or the logarithm base for `LogarithmicHistogram`/`LogHistogram` (those are aliases). In both cases, the default value is 10.
3. Minimum value. By default, it's minus infinity.
4. Maximum value. By default, it's plus infinity.

The format of the result is totally similar to [adaptive histograms](#histogram), so you can use the same [set of auxiliary functions](../../../udf/list/histogram.md).

If the spread of input values is uncontrollably large, we recommend that you specify the minimum and maximum values to prevent potential failures due to high memory consumption.

**Examples**

```yql
SELECT
    LogarithmicHistogram(numeric_column, 2)
FROM my_table;
```

