---
editable: false
---

# RAVG

_Window functions_

#### Syntax {#syntax}


```
RAVG( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Description {#description}
Returns the average of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

See also [AVG](AVG.md), [MAVG](MAVG.md).

**Argument types:**
- `value` — `Number`
- `direction` — `String`


**Return type**: `Number (whole)`

{% note info %}

Only constant values are accepted for arguments (direction).

{% endnote %}

{% note warning %}

Function depends on how data is ordered in the chart. It will work correctly only if:
- data ordering is explicitly specified in the chart;
- result is ordered by __all__ fields that don't use window functions.

{% endnote %}


#### Examples {#examples}

```
RAVG([Profit])
```

```
RAVG([Profit], "asc")
```

```
RAVG([Profit] TOTAL)
```

```
RAVG([Profit], "desc" WITHIN [Date])
```

```
RAVG([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
