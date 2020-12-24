---
editable: false
---

# Window functions
Window functions are calculated in the same way as aggregations, but they do not merge multiple entries into one. In some cases, this leads to duplication of values among entries in the same group (for example, `SUM(... TOTAL)`).

Aggregate functions are calculated from groups of values that are determined by the dimension fields used in a data query: entries with matching dimension values are grouped. Window functions are also calculated over groups of entries called _windows_. In this case, you should specify grouping parameters in the function call as a list of dimensions to be included (`WITHIN ...`) or excluded (`AMONG ...`) from the grouping.
## Usage Restrictions {#usage-restrictions}

1. Window functions can take as arguments only dimensions or aggregations (or more complex expressions composed of both). At least one of the arguments must be an aggregate expression.

    Examples:
    - Valid: `RANK(MAX([Profit]) TOTAL)`
    - Not valid: `MAX(RANK([Profit] TOTAL))`.
    - Not valid: `RANK([Profit] TOTAL)`, where `[Profit]` is not an aggregate expression.

1. The `AMONG` keyword cannot be used with dimensions that are not included in the data query.

    Example:
    - Not valid: `RANK(SUM([Profit]) AMONG [City])` with dimensions `[Order Date]` and `[Category]`.

## Syntax {#syntax}

The general syntax for window functions is as follows:
```
<WINDOW_FUNCTION_NAME>(
    arg1, arg2, ...

    [ TOTAL
    | WITHIN dim1, dim2, ...
    | AMONG dim1, dim2, ... ]

    [ ORDER BY field1, field2, ... ]

    [ BEFORE FILTER BY filtered_field1, ... ]
)
```

It starts off, just like a regular function call, with its name and arguments (`arg1, arg2, ...` in this case).

### Grouping {#syntax-grouping}

The arguments are followed by a window grouping, which can be one of three types:
- `TOTAL` (equivalent to `WITHIN` without dimensions): all query entries fall into a single window.
- `WITHIN dim1, dim2, ...` : records are grouped by the dimensions `dim1, dim2, ...`.
- `AMONG dim1, dim2, ...` : records are grouped by all dimensions from the query, except those listed. For example, if we use formula `RSUM(SUM([Sales]) AMONG dim1, dim2)` with dimensions `dim1`, `dim2`, `dim3`, `dim4` in the data query, then the entries will be grouped by `dim3` and `dim4`, so it will be equivalent to `RSUM([Sales] WITHIN dim3, dim4)`.

The grouping clause is optional. `TOTAL` is used by default.

### Ordering {#syntax-order-by}

After the grouping comes the ordering clause. It is only supported for order-dependent functions:

| `M*`                | `R*`                |
|:--------------------|:--------------------|
| [MAVG](MAVG.md)     | [RAVG](RAVG.md)     |
| [MCOUNT](MCOUNT.md) | [RCOUNT](RCOUNT.md) |
| [MMAX](MMAX.md)     | [RMAX](RMAX.md)     |
| [MMIN](MMIN.md)     | [RMIN](RMIN.md)     |
| [MSUM](MSUM.md)     | [RSUM](RSUM.md)     |

The ordering clause is optional for these functions.

See the descriptions of these functions for more information on how this order affects the result value.
The `ORDER BY` clause accepts dimensions as well as measures. It also supports the standard `ASC`/`DESC` syntax (`ASC` is assumed by default) to specify ascending or descending order respectively:
`... ORDER BY [Date] ASC, SUM([Sales]) DESC, [Category] ...`

Fields listed in `ORDER BY` are combined with fields listed in the chart's sorting section.
Example:
- Function — `... ORDER BY [Date] DESC, [City]`.
- Chart — Sorted by `Date` and `Category`.
- Result — `Date` (descending), `City`, `Category`.

### BEFORE FILTER BY {#syntax-before-filter-by}

If any fields are listed in `BEFORE FILTER BY`, then this window function is calculated before data is filtered using these fields.

`BEFORE FILTER BY` applies to all nested window functions too.
Example:
- Formula — `MAVG(RSUM([Sales] BEFORE FILTER BY [Date]), 10)'
- Equivalent — `MAVG(RSUM([Sales] BEFORE FILTER BY [Date]), 10 BEFORE FILTER BY [Date])`.

Do not use conflicting `BEFORE FILTER BY` clauses:
- Valid: `MAVG(RSUM([Sales] BEFORE FILTER BY [Date], [Category]), 10 BEFORE FILTER BY [Date])` — functions are nested and (`[Date]`) is a subset of (`[Date], [Category]`).
- Valid: `MAVG(RSUM([Sales] BEFORE FILTER BY [Category]), 10 BEFORE FILTER BY [Date])` — functions are nested, so field lists are combined in the second of the two functions.
- Valid: `RSUM([Sales] BEFORE FILTER BY [Date], [Category]) - RSUM([Sales] BEFORE FILTER BY [Date])` — (`[Date]`) is a subset of (`[Date], [Category]`).
- Not valid: `RSUM([Sales] BEFORE FILTER BY [Category]) - RSUM([Sales] BEFORE FILTER BY [Date])` — functions are not nested and neither of (`[Category]`) and (`[Date]`) is a subset of the other.

## Aggregate Functions as Window Functions {#aggregate-functions-as-window-functions}

The following aggregations can also be used as window functions:

| Aggregations             | Conditional Aggregations       |
|:-------------------------|:-------------------------------|
| [SUM](SUM_WINDOW.md)     | [SUM_IF](SUM_IF_WINDOW.md)     |
| [COUNT](COUNT_WINDOW.md) | [COUNT_IF](COUNT_IF_WINDOW.md) |
| [AVG](AVG_WINDOW.md)     | [AVG_IF](AVG_IF_WINDOW.md)     |
| [MAX](MAX_WINDOW.md)     |                                |
| [MIN](MIN_WINDOW.md)     |                                |

To use the window version of the aggregate functions, you must explicitly specify the grouping (unlike other window functions, where it is optional).

Example:
- `SUM([Sales]) / SUM(SUM([Sales]) TOTAL)` can be used to calculate the ratio of a group's sum of `[Sales]` to the sum of `[Sales]` among all entries.





## [AVG](AVG_WINDOW.md)

**Syntax:**`AVG( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values. Applicable to numeric data types.



## [AVG_IF](AVG_IF_WINDOW.md)

**Syntax:**`AVG_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values that meet the `condition` condition. If the values don't exist, it returns `NULL`. Applicable to numeric data types only.



## [COUNT](COUNT_WINDOW.md)

**Syntax:**`COUNT(  [ value ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the number of items in the specified window.



## [COUNT_IF](COUNT_IF_WINDOW.md)

**Syntax:**`COUNT_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the number of items in the specified window meeting the `expression` condition.



## [MAVG](MAVG.md)

**Syntax:**`MAVG( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving average of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

See also [AVG](AVG.md), [RAVG](RAVG.md).



## [MAX](MAX_WINDOW.md)

**Syntax:**`MAX( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the maximum value.

If `value`:
- number — Returns the largest number.
- date — Returns the latest date.
- string — Returns the last value in the alphabetic order.




## [MCOUNT](MCOUNT.md)

**Syntax:**`MCOUNT( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving count of (non-`NULL`) values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).



## [MIN](MIN_WINDOW.md)

**Syntax:**`MIN( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the minimum value.

If `value`:
- number — Returns the smallest number.
- date — Returns the earliest date.
- string — Returns the first value in the alphabetic order.




## [MMAX](MMAX.md)

**Syntax:**`MMAX( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving maximum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MAVG](MAVG.md).

See also [MAX](MAX.md), [RMAX](RMAX.md).



## [MMIN](MMIN.md)

**Syntax:**`MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).



## [MSUM](MSUM.md)

**Syntax:**`MSUM( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the moving sum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` preceding rows.                          |
| negative   | -          | The current row and -`rows_1` following rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [SUM](SUM.md), [RSUM](RSUM.md).



## [RANK](RANK.md)

**Syntax:**`RANK( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `3`, so, in effect, it is rank with gaps.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_DENSE](RANK_DENSE.md)

**Syntax:**`RANK_DENSE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value used for sorting have the same rank. If the first two rows both have rank of `1`, then the next row (if it features a different value) will have rank `2`, (rank without gaps).

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_UNIQUE](RANK_UNIQUE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RANK_PERCENTILE](RANK_PERCENTILE.md)

**Syntax:**`RANK_PERCENTILE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the relative rank (from `0` to `1`) of the current row if ordered by the given argument. Calculated as `(RANK(...) - 1) / (row count) `.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).



## [RANK_UNIQUE](RANK_UNIQUE.md)

**Syntax:**`RANK_UNIQUE( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the rank of the current row if ordered by the given argument. Rows corresponding to the same value have different rank values. This means that rank values are sequential and different for all rows, always increasing by `1` for the next row.

If `direction` is `"desc"` or omitted, then ranking is done from greatest to least, if `"asc"`, then from least to greatest.

See also [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).



## [RAVG](RAVG.md)

**Syntax:**`RAVG( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).



## [RCOUNT](RCOUNT.md)

**Syntax:**`RCOUNT( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the count of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [COUNT](COUNT.md), [MCOUNT](MCOUNT.md).



## [RMAX](RMAX.md)

**Syntax:**`RMAX( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the maximum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RAVG](RAVG.md).

See also [MAX](MAX.md), [MMAX](MMAX.md).



## [RMIN](RMIN.md)

**Syntax:**`RMIN( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the minimum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [MIN](MIN.md), [MMIN](MMIN.md).



## [RSUM](RSUM.md)

**Syntax:**`RSUM( value [ , direction ] [ TOTAL | WITHIN ... | AMONG ... ] [ ORDER BY ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [SUM](SUM.md), [MSUM](MSUM.md).



## [SUM](SUM_WINDOW.md)

**Syntax:**`SUM( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all expression values. Applicable to numeric data types only.



## [SUM_IF](SUM_IF_WINDOW.md)

**Syntax:**`SUM_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )`

Returns the sum of all the expression values that meet the `condition` condition. Applicable to numeric data types only.


