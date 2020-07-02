---
editable: false
---

# Window functions
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



## [MAVG](MAVG.md)

**Syntax:**`MAVG( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).



## [MAX](MAX.md)

**Syntax:**`MAX( value )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MCOUNT](MCOUNT.md)

**Syntax:**`MCOUNT( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).



## [MIN](MIN.md)

**Syntax:**`MIN( value )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MMAX](MMAX.md)

**Syntax:**`MMAX( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving maximum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MAVG](MAVG.md).

See also [MAX](MAX.md), [RMAX](RMAX.md).



## [MMIN](MMIN.md)

**Syntax:**`MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).



## [MSUM](MSUM.md)

**Syntax:**`MSUM( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving sum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [SUM](SUM.md), [RSUM](RSUM.md).



## [RANK](RANK.md)

**Syntax:**`RANK( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_DENSE](RANK_DENSE.md)

**Syntax:**`RANK_DENSE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `2`, (rank without gaps).

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_PERCENTILE](RANK_PERCENTILE.md)

**Syntax:**`RANK_PERCENTILE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).



## [RANK_UNIQUE](RANK_UNIQUE.md)

**Syntax:**`RANK_UNIQUE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value have different rank values. This means that rank values are sequential and different for all rows, always increasing by `1` for the next row.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RAVG](RAVG.md)

**Syntax:**`RAVG( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).



## [RCOUNT](RCOUNT.md)

**Syntax:**`RCOUNT( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the count of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [COUNT](COUNT.md), [MCOUNT](MCOUNT.md).



## [RMAX](RMAX.md)

**Syntax:**`RMAX( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the maximum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RAVG](RAVG.md).

See also [MAX](MAX.md), [MMAX](MMAX.md).



## [RMIN](RMIN.md)

**Syntax:**`RMIN( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the minimum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [MIN](MIN.md), [MMIN](MMIN.md).



## [RSUM](RSUM.md)

**Syntax:**`RSUM( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the sum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [SUM](SUM.md), [MSUM](MSUM.md).



## [SUM](SUM.md)

**Syntax:**`SUM( value )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF.md)

**Syntax:**`SUM_IF( expression, condition )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.


