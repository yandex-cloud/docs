---
editable: false
---

# RMIN

_Window functions_

#### Syntax {#syntax}


```
RMIN( value [ , direction ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Description {#description}
Returns the minimum of all values in a growing (or shrinking) window defined by the sort order and the value of `direction`:

| `direction`   | Window                                                 |
|:--------------|:-------------------------------------------------------|
| `"asc"`       | Starts from the first row and ends at the current row. |
| `"desc"`      | Starts from the current row and ends at the last row.  |

By default `"asc"` is used.


Window functions with a similar behavior: [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

See also [MIN](MIN.md), [MMIN](MMIN.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Number | String | UUID`
- `direction` — `String`


**Return type**: Same type as (`value`)

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
RMIN([Profit])
```

```
RMIN([Profit], "asc")
```

```
RMIN([Profit] TOTAL)
```

```
RMIN([Profit], "desc" WITHIN [Date])
```

```
RMIN([Profit] AMONG [Date])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
