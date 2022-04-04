---
title: Aggregate functions
description: Aggregate functions (or aggregations) are functions that combine multiple values from a group of entries into one, thus collapsing the group into a single entry.
keywords:
- aggregate functions
- aggregations
- aggregate data
- level of detail
- lod
editable: false
sourcePath: en/_api-ref/datalens/function-ref/aggregation-functions.md
---

# Aggregate functions
Aggregate functions (or aggregations) are functions that combine multiple values from a group of entries into one, thus collapsing the group into a single entry.

If you add an aggregation to a dimension, it becomes a measure.

## Syntax {#syntax}

In most cases aggregate functions have the same syntax as regular functions:
```
AGGREGATE_FUNCTION_NAME(arg1, [arg2, ...])
```

For advanced cases, extended syntax may be required to indicate a custom level of detail (LOD):
```
<AGGREGATE_FUNCTION_NAME>(
    arg1, [arg2, ...]

    [ FIXED dim1, dim2, ...
    | INCLUDE dim1, dim2, ...
    | EXCLUDE dim1, dim2, ... ]

    [ BEFORE FILTER BY filtered_field1, ... ]
)
```
### Level of Detail (LOD) {#syntax-lod}

Custom LOD make possible nested aggregations and aggregations over the entire set of rows or groups that are different from the grouping at the chart's level.

LOD can be specified using one of three keywords:
- `FIXED` — data is grouped using the listed dimensions (`dim1, dim2, ...`) regardless of the dimensions used by the chart;
- `INCLUDE` — the listed dimensions (`dim1, dim2, ...`) are combined with the chart's dimensions;
- `EXCLUDE` — all of the chart's dimensions are used with the exception of those listed (`dim1, dim2, ...`).

For any of these keywords the list may have any number of dimensions, or even be empty.

#### Dimension Inheritance {#syntax-lod-inheritance}
Dimensions are inherited by nested aggregations from the ones they are inside of. The expression
```
AVG(MAX(SUM([Sales] INCLUDE [City]) INCLUDE [Category]))
```
in a chart with the additional dimension `[Date]` is equivalent to
```
AVG(MAX(SUM([Sales] FIXED [City], [Category], [Date]) FIXED [Category], [Date]) FIXED [Date])
```
`INCLUDE` or `EXCLUDE` without a list of dimensions results in the same dimensions as the aggregation above or dimensions of the chart if it is the topmost aggregation. `FIXED` without a list means that all data is aggregated in a single group, which can be used to calculate total values.

#### LOD Examples {#syntax-lod-examples}

- average daily sum of `[Sales]`: `AVG(SUM([Sales] INCLUDE [Date]))`;
- ratio of the (daily) sum of `[Sales]` to the total sum: `SUM([Sales]) / SUM([Sales] FIXED)`;
- sum of `[Sales]` of all orders that are smaller than average: `SUM_IF(SUM([Sales] INCLUDE [Order ID]), SUM([Sales] INCLUDE [Order ID]) < AVG([Sales] FIXED))`.

#### Dimension Compatibility {#syntax-lod-compatibility}

If several aggregations with custom LODs are nested inside another, their sets of dimensions must be compatible, i.e. one of them must contain all of the others.

Invalid expression:
```
SUM(AVG([Sales] INCLUDE [City]) - AVG([Sales] INCLUDE [Category]))
```
One of the nested aggregations has dimension `[City]`, while the other has `[Category]`, and there is no other that would contain both of these.

Valid expression:
```
SUM(
    AVG([Sales] INCLUDE [City], [Category])
    - (AVG([Sales] INCLUDE [City]) + AVG([Sales] INCLUDE [Category])) / 2
)
```

One of the nested aggregations' set of dimensions contains all of the others.

Another important restriction for LOD is that top-level aggregations must not contain any dimensions not used in the chart.

### BEFORE FILTER BY {#syntax-before-filter-by}

If any fields are listed in `BEFORE FILTER BY`, then this aggregate function is calculated before data is filtered using these fields.

`BEFORE FILTER BY` applies to all nested aggregate functions too.
Example:
- Formula — `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City]))`.
- Equivalent — `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City]) BEFORE FILTER BY [Category])`.

Do not use conflicting `BEFORE FILTER BY` clauses:
- Valid: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City], [Category]) BEFORE FILTER BY [City])` — functions are nested and (`[City]`) is a subset of (`[City], [Category]`).
- Valid: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [Category]) BEFORE FILTER BY [City])` — functions are nested, so field lists are combined in the second of the two functions.
- Valid: `SUM([Sales] BEFORE FILTER BY [City], [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — (`[City]`) is a subset of (`[City], [Category]`).
- Not valid: `SUM([Sales] BEFORE FILTER BY [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — functions are not nested and neither of (`[Category]`) and (`[City]`) is a subset of the other.

## Usage Restrictions {#usage-restrictions}

There are the following features of using aggregations:
1. A function or operator cannot have aggregate and non-aggregate expressions as its arguments simultaneously. The following usage is forbidden: `CONCAT([Profit], SUM([Profit]))`.



## [ALL_CONCAT](ALL_CONCAT.md)

**Syntax:**`ALL_CONCAT( expression [ , separator ] )`

Returns a string that contains all grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [ANY](ANY.md)

**Syntax:**`ANY( value )`

Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.



## [ARG_MAX](ARG_MAX.md)

**Syntax:**`ARG_MAX( value, comp )`

Returns `value` for the maximum value of `comp` in the group. If multiple values of `value` match the maximum value of `comp`, then the first one encountered is returned. This makes the function non-deterministic.



## [ARG_MIN](ARG_MIN.md)

**Syntax:**`ARG_MIN( value, comp )`

Returns `value` for the minimum value of `comp` in the group. If multiple values of `value` match the minimum value of `comp`, then the first one encountered is returned. This makes the function non-deterministic.



## [AVG](AVG.md)

**Syntax:**`AVG( value )`

Returns the average of all values. Applicable to numeric data types as well as `Date | Datetime`.



## [AVG_IF](AVG_IF.md)

**Syntax:**`AVG_IF( expression, condition )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [COUNT](COUNT.md)

**Syntax:**`COUNT(  [ value ] )`

Returns the number of items in the group.



## [COUNT_IF](COUNT_IF.md)

**Syntax:**`COUNT_IF( condition )`

Returns the number of items in the group meeting the `condition` condition.



## [COUNTD](COUNTD.md)

**Syntax:**`COUNTD( value )`

Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [COUNTD_APPROX](COUNTD_APPROX.md)

**Syntax:**`COUNTD_APPROX( value )`

Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.



## [COUNTD_IF](COUNTD_IF.md)

**Syntax:**`COUNTD_IF( expression, condition )`

Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [MAX](MAX.md)

**Syntax:**`MAX( value )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MEDIAN](MEDIAN.md)

**Syntax:**`MEDIAN( value )`

Returns the median value.



## [MIN](MIN.md)

**Syntax:**`MIN( value )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [QUANTILE](QUANTILE.md)

**Syntax:**`QUANTILE( value, quant )`

Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Syntax:**`QUANTILE_APPROX( value, quant )`

Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).



## [STDEV](STDEV.md)

**Syntax:**`STDEV( value )`

Returns the statistical standard deviation of all values in the expression based on a selection from the population.



## [STDEVP](STDEVP.md)

**Syntax:**`STDEVP( value )`

Returns the statistical standard deviation of all values in the expression based on the biased population.



## [SUM](SUM.md)

**Syntax:**`SUM( value )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF.md)

**Syntax:**`SUM_IF( expression, condition )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [TOP_CONCAT](TOP_CONCAT.md)

**Syntax:**`TOP_CONCAT( expression, amount [ , separator ] )`

Returns a string that contains top `amount` grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [VAR](VAR.md)

**Syntax:**`VAR( value )`

Returns the statistical variance of all values in an expression based on a selection from the population.



## [VARP](VARP.md)

**Syntax:**`VARP( value )`

Returns the statistical variance of all values in an expression across the entire population.


