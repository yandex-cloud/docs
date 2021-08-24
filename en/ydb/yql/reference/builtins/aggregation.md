# Aggregate functions

## COUNT {#count}

Counting the number of rows in the table (if `*` or constant is specified as the argument) or non-empty values in a table column (if the column name is specified as an argument).

Like other aggregate functions, it can be combined with [GROUP BY](../syntax/group_by.md) to get statistics on the parts of the table that correspond to the values in the columns being grouped. Use the [DISTINCT](../syntax/group_by.md#distinct) modifier to count the number of unique values.

**Examples**

```sql
SELECT COUNT(*) FROM my_table;
```

```sql
SELECT key, COUNT(value) FROM my_table GROUP BY key;
```

```sql
SELECT COUNT(DISTINCT value) FROM my_table;
```

## MIN and MAX {#min-max}

Minimum or maximum value.

As an argument, you may use an arbitrary computable expression with a numeric result.

**Examples**

```sql
SELECT MIN(value), MAX(value) FROM my_table;
```

## SUM {#sum}

Sum of the numbers.

As an argument, you may use an arbitrary computable expression with a numeric result.

Integers are automatically expanded to 64 bits to reduce the risk of overflow.

```sql
SELECT SUM(value) FROM my_table;
```

## AVG {#avg}

Arithmetic average.

As an argument, you may use an arbitrary computable expression with a numeric result.

Integer values and time intervals are automatically converted to Double.

**Examples**

```sql
SELECT AVG(value) FROM my_table;
```

## COUNT_IF {#count-if}

Number of rows for which the expression specified as the argument is true (the expression's calculation result is true).

The value `NULL` is equated to `false` (if the argument type is `Bool?`).

The function *does not* do the implicit type casting to Boolean for strings and numbers.

**Examples**

```sql
SELECT
  COUNT_IF(value % 2 == 1) AS odd_count
```

{% note info %}

If you need to count the number of unique values on the rows that meet the condition, then unlike other aggregate functions, you can't use the [DISTINCT](../syntax/group_by.md#distinct) modifier, since the arguments contain no values. To get this result, use, inside a subquery, the built-in [IF](../builtins/basic.md#if) function with two arguments (to get `NULL` in ELSE), and apply an outer [COUNT(DISTINCT ...)](#count) to its results.

{% endnote %}

## SUM_IF and AVG_IF {#sum-if}

Sum or arithmetic average, but only for the rows that satisfy the condition passed by the second argument.

Therefore, `SUM_IF(value, condition)` is a slightly shorter notation for `SUM(IF(condition, value))`, same for `AVG`. The argument's data type expansion is similar to the same-name functions without a suffix.

When you use [aggregation factories](basic.md#aggregationfactory), a `Tuple` containing a value and predicate is passed as the first [AGGREGATE_BY](#aggregateby) argument.

**Examples**

```sql
SELECT
    SUM_IF(value, value % 2 == 1) AS odd_sum,
    AVG_IF(value, value % 2 == 1) AS odd_avg,
FROM my_table;
```

```sql
$sum_if_factory = AGGREGATION_FACTORY("SUM_IF");
$avg_if_factory = AGGREGATION_FACTORY("AVG_IF");

SELECT
    AGGREGATE_BY(AsTuple(value, value % 2 == 1), $sum_if_factory) AS odd_sum,
    AGGREGATE_BY(AsTuple(value, value % 2 == 1), $avg_if_factory) AS odd_avg
FROM my_table;
```

## CountDistinctEstimate, HyperLogLog, and HLL {#countdistinctestimate}

Approximating the number of unique values using the [HyperLogLog](https://en.wikipedia.org/wiki/HyperLogLog) algorithm. Logically, it does the same thing as [COUNT(DISTINCT ...)](#count), but runs much faster at the cost of some error.

Arguments:

1. Estimated value
2. Accuracy (4 to 18 inclusive, 14 by default).

By selecting accuracy, you can trade added resource and RAM consumption for decreased error.

All the three functions are aliases at the moment, but `CountDistinctEstimate` may start using a different algorithm in the future.

**Examples**

```sql
SELECT
  CountDistinctEstimate(my_column)
FROM my_table;
```

```sql
SELECT
  HyperLogLog(my_column, 4)
FROM my_table;
```

## SOME {#some}

Get the value for an expression specified as an argument, for one of the table rows. Gives no guarantee of which row is used. It's similar to the [any()]{% if lang == "ru" %}(https://clickhouse.tech/docs/ru/sql-reference/aggregate-functions/reference/any/){% endif %}{% if lang == "en" %}(https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/any/){% endif %} function in ClickHouse.

Because of no guarantee, `SOME` is computationally cheaper than [MIN](#min)/[MAX](#max) often used in similar situations.

**Examples**

```sql
SELECT
  SOME(value)
FROM my_table;
```

{% note alert %}

When the aggregate function `SOME` is called multiple times, it's **not** guaranteed that all the resulting values are taken from the same row of the source table. To get this guarantee, pack the values into any container and pass it to `SOME`. For example, for a structure you can do this using [AsStruct](../builtins/basic.md#asstruct)

{% endnote %}

## LIST {#list}

Get all column values as a list. When combined with `DISTINCT`, it returns only distinct values. The order of items in the result list depends on the implementation and can't be set externally. To get an ordered list, sort the result, for example, using [ListSort](list.md#listsort).

For example, you can use it together with `DISTINCT` and the function [String::JoinFromList](../udf/list/string.md) (an analog of  Python's `','.join(list)`) to print all the values that got into a column after `GROUP BY`, as one string.

{% note alert %}

Execution is **not** lazy, so when you use it, be sure that the list has a reasonable size (about a thousand items or less). To stay on the safe side, better use a second optional numeric argument that limits the number of items in the list.

{% endnote %}

Note that the function's result can be a `List` or `List?` ([optional](../types/optional)), depending on the context.

**Examples**

```sql
-- In the context of GROUP BY, it has the List type
SELECT LIST(ip, 1)
FROM [//home/yql/tutorial/users]
GROUP BY age
```

```sql
-- In a context without GROUP BY, it has the optional List? type
SELECT LIST(ip, 1)
FROM [//home/yql/tutorial/users]
```

## MAX_BY and MIN_BY {#max-min-by}

Return the value of the first argument for the table row where the second argument is minimum/maximum.

You can optionally specify the third argument N that affects behavior if the table has multiple rows with the same minimum or maximum value:

* If N is omitted, the value of one of the rows is returned, and the other rows are discarded.
* If N is specified, the list is returned with all values, but their number can't exceed N. All values after the number are discarded.

When choosing N, we recommend that you don't exceed several hundreds or thousands to avoid issues with the limited memory available on clusters.

If your task needs absolutely all values, and their number is measured in dozens of thousands or more, then instead of those aggregate functions better use `JOIN` on the source table with a subquery doing `GROUP BY + MIN/MAX` on the desired columns of this table.

{% note alert %}

If the second argument is always NULL, the aggregation result is NULL.

{% endnote %}

When you use [aggregation factories](basic.md#aggregationfactory), a `Tuple` containing a value and key is passed as the first [AGGREGATE_BY](#aggregateby) argument.

**Examples**

```sql
SELECT
  MIN_BY(value, LENGTH(value)),
  MAX_BY(value, key, 100)
FROM my_table;
```

```sql
$min_by_factory = AGGREGATION_FACTORY("MIN_BY");
$max_by_factory = AGGREGATION_FACTORY("MAX_BY", 100);

SELECT
    AGGREGATE_BY(AsTuple(value, LENGTH(value)), $min_by_factory),
    AGGREGATE_BY(AsTuple(value, key), $max_by_factory)
FROM my_table;
```

## TOP and BOTTOM {#top-button}

Return a list of the maximum/minimum values of an expression. The first argument is an expression, the second argument limits the number of items.

**Examples**

```sql
SELECT
  TOP(key, 3),
  BOTTOM(value, 3)
FROM my_table;
```

```sql
$top_factory = AGGREGATION_FACTORY("TOP", 3);
$bottom_factory = AGGREGATION_FACTORY("BOTTOM", 3);

SELECT
    AGGREGATE_BY(key, $top_factory),
    AGGREGATE_BY(value, $bottom_factory)
FROM my_table;
```

## TOP_BY and BOTTOM_BY {#top-bottom-by}

Return a list of values of the first argument for the rows containing the maximum/minimum values of the second argument. The third argument limits the number of items in the list.

When you use [aggregation factories](basic.md#aggregationfactory), a `Tuple` containing a value and key is passed as the first [AGGREGATE_BY](#aggregateby) argument. In this case, the limit for the number of items is passed by the second argument at factory creation.

**Examples**

```sql
SELECT
  TOP_BY(value, LENGTH(value), 3),
  BOTTOM_BY(value, key, 3)
FROM my_table;
```

```sql
$top_by_factory = AGGREGATION_FACTORY("TOP_BY", 3);
$bottom_by_factory = AGGREGATION_FACTORY("BOTTOM_BY", 3);

SELECT
    AGGREGATE_BY(AsTuple(value, LENGTH(value)), $top_by_factory),
    AGGREGATE_BY(AsTuple(value, key), $bottom_by_factory)
FROM my_table;
```

## TOPFREQ and MODE {#topfreq}

Getting an approximate list of the most common values in a column with an estimation of their count. Returns a list of structures with two fields:

* `Value`: the frequently occurring value that was found.
* `Frequency`: An estimated value occurrence in the table.

Required argument: the value itself.

Optional arguments:

1. For `TOPFREQ`, the desired number of items in the result. `MODE` is an alias to `TOPFREQ` with this argument set to 1. For `TOPFREQ`, this argument is also 1 by default.
2. The number of items in the buffer used: lets you trade memory consumption for accuracy. Default: 100.

**Examples**

```sql
SELECT
    MODE(my_column),
    TOPFREQ(my_column, 5, 1000)
FROM my_table;
```

## STDDEV and VARIANCE {#stddev-variance}

Standard deviation and variance in a column. Those functions use a [single-pass parallel algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Parallel_algorithm), whose result may differ from the more common methods requiring two passes through the data.

By default, the sample variance and standard deviation are calculated. Several write methods are available:

* With the `POPULATION` suffix/prefix, see **Examples** `VARIANCE_POPULATION`, `POPULATION_VARIANCE` calculate variance/standard deviation for the population.
* With the `SAMPLE` suffix/prefix or without a suffix, for example, `VARIANCE_SAMPLE`, `SAMPLE_VARIANCE`, `SAMPLE` calculate sample variance and standard deviation.

Several abbreviated aliases are also defined, for example, `VARPOP` or `STDDEVSAMP`.

If all the values passed are `NULL`, it returns `NULL`.

**Examples**

```sql
SELECT
  STDDEV(numeric_column),
  VARIANCE(numeric_column)
FROM my_table;
```

## CORRELATION and COVARIANCE {#correlation-covariance}

Correlation and covariance between two columns.

Abbreviated versions are also available: `CORR` or `COVAR`. For covariance, there are also versions with the `SAMPLE` / `POPULATION` suffix similar to [VARIANCE](#variance) above.

Unlike most other aggregate functions, they don't skip `NULL`, but accept it as 0.

When you use [aggregation factories](basic.md#aggregationfactory), a `Tuple` containing two values is passed as the first [AGGREGATE_BY](#aggregateby) argument.

**Examples**

```sql
SELECT
  CORRELATION(numeric_column, another_numeric_column),
  COVARIANCE(numeric_column, another_numeric_column)
FROM my_table;
```

```sql
$corr_factory = AGGREGATION_FACTORY("CORRELATION");

SELECT
    AGGREGATE_BY(AsTuple(numeric_column, another_numeric_column), $corr_factory)
FROM my_table;
```

## PERCENTILE and MEDIAN {#percentile-median}

{% note alert %}

The first argument (N) must be a table column name. If you need to bypass this restriction, use a subquery. The restriction is introduced to simplify calculations, since the implementation merges the calls with the same first argument (N) into a single pass.

{% endnote %}

```sql
SELECT
    MEDIAN(numeric_column),
    PERCENTILE(numeric_column, 0.99)
FROM my_table;
```

## HISTOGRAM {#histogram}

Plotting an approximate histogram based on a numeric expression with automatic selection of buckets.

Auxiliary functions are listed in the section [Histogram UDF](../udf/list/histogram.md).

### Basic settings {#basic-settings}

You can limit the number of buckets using an optional argument. The default value is 100. Keep in mind that added accuracy costs you more computing resources and may negatively affect the query execution time. In extreme cases, it may affect your query success.

### Support for weights {#weight-support}

You can specify a "weight" for each value used in the histogram. To do this, pass to the aggregate function the second argument with an expression for calculating the weight. The weight of `1.0` is always used by default. If you use non-standard weights, you may also use the third argument to limit the number of buckets.

If you pass two arguments, the meaning of the second argument is determined by its type (if it's an integer literal, it limits the number of buckets, otherwise it's used as a weight).

### If you need an accurate histogram {#if-you-need-an-accurate-histogram}

1. You can use the aggregate functions described below with fixed bucket grids: [LinearHistogram](#linearhistogram) or [LogarithmicHistogram](#logarithmichistogram).
2. You can calculate the bucket number for each row and [GROUP BY](../syntax/group_by.md) it.

When you use [aggregation factories](basic.md#aggregationfactory), a `Tuple` containing a value and weight is passed as the first [AGGREGATE_BY](#aggregateby) argument.

**Examples**

```sql
SELECT
        HISTOGRAM(numeric_column)
FROM my_table;
```

```sql
SELECT
    Histogram::Print(
        HISTOGRAM(numeric_column, 10),
        50
    )
FROM my_table;
```

```sql
$hist_factory = AGGREGATION_FACTORY("HISTOGRAM");

SELECT
    AGGREGATE_BY(AsTuple(numeric_column, 1.0), $hist_factory)
FROM my_table;
```

## LinearHistogram, LogarithmicHistogram, and LogHistogram {%linearhistogram} {#linearhistogram-logarithmichistogram-and-loghistogram-linearhistogram}

Plotting a histogram based on an explicitly specified fixed bucket scale.

Arguments:

1. Expression used to plot the histogram. All the following arguments are optional.
2. Spacing between the `LinearHistogram` buckets or the logarithm base for `LogarithmicHistogram`/`LogHistogram` (those are aliases). In both cases, the default value is 10.
3. Minimum value. By default, it's minus infinity.
4. Maximum value. By default, it's plus infinity.

The format of the result is totally similar to [adaptive histograms](#histogram), hence you can use the same [set of auxiliary functions](../udf/list/histogram.md).

If the spread of input values is uncontrollably large, we recommend that you specify the minimum and maximum values to prevent potential failures due to high memory consumption.

**Examples**

```sql
SELECT
    LogarithmicHistogram(numeric_column, 2)
FROM my_table;
```

## BOOL_AND and BOOL_OR {#bool-and-or}

Apply the relevant logical operation (`AND/OR`) to all values in a Boolean column or expression.

The operation logic is equivalent to the Python functions `all()` and `any()`, respectively.

**Examples**

```sql
SELECT
  BOOL_AND(bool_column),
  BOOL_OR(bool_column)
FROM my_table;
```

## BIT_AND, BIT_OR, and BIT_XOR {#bit-and-or-xor}

Apply the relevant bitwise operation to all values of a numeric column or expression.

**Examples**

```sql
SELECT
  BIT_XOR(unsigned_numeric_value)
FROM my_table;
```

## AGGREGATE_BY and MULTI_AGGREGATE_BY {#aggregateby}

Apply the [aggregation factory](basic.md#aggregationfactory) to all values of a column or expression. The `MULTI_AGGREGATE_BY` function requires that the value of a column or expression contains a structure, and applies the factory element-by-element, placing the result into a structure with the same fields.

1. Column, `DISTINCT` column or expression.
2. Factory.

**Examples**

```sql
$count_factory = AGGREGATION_FACTORY("COUNT");

SELECT
    AGGREGATE_BY(DISTINCT column, $count_factory) as uniq_count
FROM my_table;

SELECT
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("count")) as count,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("min")) as min,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("max")) as max,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("avg")) as avg,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("percentile", 0.9)) as p90
FROM my_table;
```

