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

Aggregate functions can be used with constants, such as `COUNT(1)` or `SUM(1)`. If the chart does not use other measures and dimensions, the result of such an expression will always be `1`. This is because the function does not include any fields, so {{ datalens-short-name }} accesses no source tables in the query.

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
* `FIXED` — data is grouped using the listed dimensions (`dim1, dim2, ...`) regardless of the dimensions used by the chart;
* `INCLUDE` — the listed dimensions (`dim1, dim2, ...`) are combined with the chart's dimensions;
* `EXCLUDE` — all of the chart's dimensions are used with the exception of those listed (`dim1, dim2, ...`).

For any of these keywords the list may have any number of dimensions, or even be empty.

Using `INCLUDE` or `EXCLUDE` without a dimension list is equivalent to grouping by dimensions of an external aggregation or by chart dimensions if there are no other aggregations over the current one. `FIXED` without a list means that all data will aggregate into a single group, e.g., for calculating the resulting value.

Top-level aggregations must not contain any dimensions that are missing in the chart. Hence, if you need to add details or group by dimensions that are missing in the chart, you can add them in the lower levels. For example, if you need the maximum sales amount by cities without including data on cities to the chart, use:
```
MAX(SUM([Sales] FIXED [City]))
```

#### Dimension Inheritance {#syntax-lod-inheritance}
Dimensions are inherited by nested aggregations from the ones they are inside of. The expression
```
AVG(MAX(SUM([Sales] INCLUDE [City]) INCLUDE [Category]))
```
in a chart with the additional dimension `[Date]` is equivalent to
```
AVG(MAX(SUM([Sales] FIXED [City], [Category], [Date]) FIXED [Category], [Date]) FIXED [Date])
```


#### LOD Examples {#syntax-lod-examples}

* Average daily sum of `[Sales]`: `AVG(SUM([Sales] INCLUDE [Date]))`;
* Ratio of the (daily) sum of `[Sales]` to the total sum: `SUM([Sales]) / SUM([Sales] FIXED)`;
* Sum of `[Sales]` of all orders that are smaller than average: `SUM_IF(SUM([Sales] INCLUDE [Order ID]), SUM([Sales] INCLUDE [Order ID]) < AVG([Sales] FIXED))`.

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

One of the nested aggregations set of dimensions contains all of the others.


### BEFORE FILTER BY {#syntax-before-filter-by}

If any fields are listed in `BEFORE FILTER BY`, then this aggregate function is calculated before data is filtered using these fields.

`BEFORE FILTER BY` applies to all nested aggregate functions too.
Example:
* Formula — `AVG(SUM([Sales] INCLUDE [Date]) BEFORE FILTER BY [City])`.
* Equivalent — `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City]) BEFORE FILTER BY [City])`.

Do not use conflicting `BEFORE FILTER BY` clauses:
* Valid: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City], [Category]) BEFORE FILTER BY [City])` — functions are nested and (`[City]`) is a subset of (`[City], [Category]`).
* Valid: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [Category]) BEFORE FILTER BY [City])` — functions are nested, so field lists are combined in the second of the two functions.
* Valid: `SUM([Sales] BEFORE FILTER BY [City], [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — (`[City]`) is a subset of (`[City], [Category]`).
* Not valid: `SUM([Sales] BEFORE FILTER BY [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — functions are not nested and neither of (`[Category]`) and (`[City]`) is a subset of the other.

## Usage Restrictions {#usage-restrictions}

There are the following features of using aggregations: a function or operator cannot have aggregate and non-aggregate expressions as its arguments simultaneously. The following usage is forbidden: `CONCAT([Profit], SUM([Profit]))`.



## [ALL_CONCAT](ALL_CONCAT.md)

**Syntax:**<br/>`ALL_CONCAT( expression [ , separator ] )`<br/>or<br/>`ALL_CONCAT( expression [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Returns a string that contains all unique values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [ANY](ANY.md)

**Syntax:**<br/>`ANY( value )`<br/>or<br/>`ANY( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.



## [ARG_MAX](ARG_MAX.md)

**Syntax:**<br/>`ARG_MAX( value, expression_to_maximize )`<br/>or<br/>`ARG_MAX( value, expression_to_maximize
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Returns `value` for the maximum value of `expression_to_maximize` in the group. If multiple values of `value` match the maximum value of `expression_to_maximize`, then the first one encountered is returned. This makes the function non-deterministic.



## [ARG_MIN](ARG_MIN.md)

**Syntax:**<br/>`ARG_MIN( value, expression_to_minimize )`<br/>or<br/>`ARG_MIN( value, expression_to_minimize
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Returns `value` for the minimum value of `expression_to_minimize` in the group. If multiple values of `value` match the minimum value of `expression_to_minimize`, then the first one encountered is returned. This makes the function non-deterministic.



## [AVG](AVG.md)

**Syntax:**<br/>`AVG( value )`<br/>or<br/>`AVG( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the average of all values. Applicable to numeric data types as well as `Date`.



## [AVG_IF](AVG_IF.md)

**Syntax:**<br/>`AVG_IF( expression, condition )`<br/>or<br/>`AVG_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [COUNT](COUNT.md)

**Syntax:**<br/>`COUNT(  [ value ] )`<br/>or<br/>`COUNT(  [ value ]
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Returns the number of items in the group.

Can be used with constants, such as `COUNT(1)` or `COUNT()`. If the chart does not use other measures and dimensions, the result of such an expression will always be `1`. This is because the function does not include any fields, so {{ datalens-short-name }} accesses no source tables in the query.



## [COUNT_IF](COUNT_IF.md)

**Syntax:**<br/>`COUNT_IF( condition )`<br/>or<br/>`COUNT_IF( condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Returns the number of items in the group meeting the `condition` condition.



## [COUNTD](COUNTD.md)

**Syntax:**<br/>`COUNTD( value )`<br/>or<br/>`COUNTD( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the number of unique values in the group.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [COUNTD_APPROX](COUNTD_APPROX.md)

**Syntax:**<br/>`COUNTD_APPROX( value )`<br/>or<br/>`COUNTD_APPROX( value
               [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
               [ BEFORE FILTER BY ... ]
             )`

Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.



## [COUNTD_IF](COUNTD_IF.md)

**Syntax:**<br/>`COUNTD_IF( expression, condition )`<br/>or<br/>`COUNTD_IF( expression, condition
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )`

Returns the number of unique values in the group that meet the `condition` condition.

See also [COUNTD_APPROX](COUNTD_APPROX.md).



## [MAX](MAX.md)

**Syntax:**<br/>`MAX( value )`<br/>or<br/>`MAX( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MEDIAN](MEDIAN.md)

**Syntax:**<br/>`MEDIAN( value )`<br/>or<br/>`MEDIAN( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the [median](https://en.wikipedia.org/wiki/Median) value. For an even number of items, it returns the greatest of the neighboring items in the central position.



## [MIN](MIN.md)

**Syntax:**<br/>`MIN( value )`<br/>or<br/>`MIN( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [QUANTILE](QUANTILE.md)

**Syntax:**<br/>`QUANTILE( value, quant )`<br/>or<br/>`QUANTILE( value, quant
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Syntax:**<br/>`QUANTILE_APPROX( value, quant )`<br/>or<br/>`QUANTILE_APPROX( value, quant
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )`

Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).



## [STDEV](STDEV.md)

**Syntax:**<br/>`STDEV( value )`<br/>or<br/>`STDEV( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Returns the statistical [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of all values in the expression based on a selection from the population.



## [STDEVP](STDEVP.md)

**Syntax:**<br/>`STDEVP( value )`<br/>or<br/>`STDEVP( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the statistical [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of all values in the expression based on the biased population. The function shows how far data points are from their average. In other words, standard deviation shows to what extent values in a dataset deviate from their average.



## [SUM](SUM.md)

**Syntax:**<br/>`SUM( value )`<br/>or<br/>`SUM( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF.md)

**Syntax:**<br/>`SUM_IF( expression, condition )`<br/>or<br/>`SUM_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.



## [TOP_CONCAT](TOP_CONCAT.md)

**Syntax:**<br/>`TOP_CONCAT( expression, amount [ , separator ] )`<br/>or<br/>`TOP_CONCAT( expression, amount [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Returns a string that contains top `amount` unique values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).



## [VAR](VAR.md)

**Syntax:**<br/>`VAR( value )`<br/>or<br/>`VAR( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Returns the statistical variance of all values in an expression based on a selection from the population.



## [VARP](VARP.md)

**Syntax:**<br/>`VARP( value )`<br/>or<br/>`VARP( value
      [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
      [ BEFORE FILTER BY ... ]
    )`

Returns the statistical variance of all values in an expression across the entire population.


