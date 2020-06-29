---
editable: false
---

# Aggregate functions
Aggregate functions (or aggregations) are functions that combine multiple values from a group of entries into one, thus collapsing the group into a single entry.

If you add an aggregation to a dimension, it becomes a measure.

## Usage Restrictions {#usage-restrictions}

There are the following features of using aggregations:
1. An aggregate function cannot be nested into another aggregation. The following usage is forbidden: `MAX(SUM([Sales]))`. Any expression can be aggregated only once.
2. A function or operator cannot have aggregate and non-aggregate expressions as its arguments simultaneously. The following usage is forbidden: `CONCAT([Profit], SUM([Profit]))`.



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

Returns the precise `value`-level quantile (`value` should be in range from 0 to 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Syntax:**`QUANTILE_APPROX( value, quant )`

Returns the approximate `value`-level quantile (`value` should be in range from 0 to 1).



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



## [VAR](VAR.md)

**Syntax:**`VAR( value )`

Returns the statistical variance of all values in an expression based on a selection from the population.



## [VARP](VARP.md)

**Syntax:**`VARP( value )`

Returns the statistical variance of all values in an expression across the entire population.


