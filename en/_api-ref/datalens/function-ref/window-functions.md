---
editable: false
---

# Window functions
Window functions are calculated in the same way as aggregations, but they do not merge multiple entries into one. In some cases, this leads to duplication of values among entries in the same group (for example, `SUM(... TOTAL)`).

Aggregate functions are calculated from groups of values that are determined by the dimension fields used in a data query: entries with matching dimension values are grouped. Window functions are also calculated over groups of entries called _windows_. In this case, you should specify grouping parameters in the function call as a list of dimensions to be included (`WITHIN ...`) or excluded (`AMONG ...`) from the grouping.
## Usage Restrictions {#usage-restrictions}

1. Window functions can take as arguments only dimensions or aggregations (or more complex expressions composed of both).

    Example:
    - Valid expression: `RANK(MAX([Profit]) TOTAL)`
    - Not valid expression: `MAX(RANK([Profit] TOTAL))`.

2. A window function cannot be nested into another window function.

3. The `AMONG` keyword cannot be used with dimensions that are not included in the data query.

## Syntax {#syntax}

The general syntax for window functions is as follows:
```
<WINDOW_FUNCTION_NAME>(
    arg1, arg2, ...
    [ TOTAL
    | WITHIN dim1, dim2, ...
    | AMONG dim1, dim2, ... ]
)
```

The values of `arg1, arg2, ...` are the function arguments. The arguments are followed by a window grouping, which can be one of three types:
- `TOTAL` (equivalent to `WITHIN` without dimensions): all query entries fall into a single window.
- `WITHIN dim1, dim2, ...` : records are grouped by the dimensions `dim1, dim2, ...`.
- `AMONG dim1, dim2, ...` : records are grouped by all dimensions from the query, except those listed. For example, if the dimensions `dim1`, `dim2`, `dim3`, `dim4` are present in the data query, then the entries are grouped by `dim3`, `dim4`.

The grouping clause is optional. `TOTAL` is used by default.

## Aggregate Functions as Window Functions {#aggregate-functions-as-window-functions}

The following aggregations can also be used as window functions:

| Aggregations      | Conditional Aggregations   |
|:------------------|:---------------------------|
| [SUM](SUM.md)     | [SUM_IF](SUM_IF.md)        |
| [COUNT](COUNT.md) | [COUNT_IF](COUNT_IF.md)    |
| [AVG](AVG.md)     | [AVG_IF](AVG_IF.md)        |
| [MAX](MAX.md)     |                            |
| [MIN](MIN.md)     |                            |

To use the window version of the aggregate functions, you must explicitly specify the grouping (unlike other window functions, where it is optional).

Example:
- `SUM([Sales]) / SUM(SUM([Sales]) TOTAL)` can be used to calculate the ratio of a group's sum of `[Sales]` to the sum of `[Sales]` among all entries.





## [MAVG](MAVG.md)

**Syntax:**`MAVG( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).



## [MCOUNT](MCOUNT.md)

**Syntax:**`MCOUNT( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).



## [MMAX](MMAX.md)

**Syntax:**`MMAX( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving maximum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MAVG](MAVG.md).

See also [MAX](MAX.md), [RMAX](RMAX.md).



## [MMIN](MMIN.md)

**Syntax:**`MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).



## [MSUM](MSUM.md)

**Syntax:**`MSUM( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the moving sum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [SUM](SUM.md), [RSUM](RSUM.md).



## [RANK](RANK.md)

**Syntax:**`RANK( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_DENSE](RANK_DENSE.md)

**Syntax:**`RANK_DENSE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `2`, (rank without gaps).

See also [RANK](RANK.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_PERCENTILE](RANK_PERCENTILE.md)

**Syntax:**`RANK_PERCENTILE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).



## [RANK_UNIQUE](RANK_UNIQUE.md)

**Syntax:**`RANK_UNIQUE( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value have different rank values. This means that rank values are sequential and different for all rows, always increasing by `1` for the next row.

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


