---
editable: false
---

# MMIN

_Window functions_

#### Syntax


```
MMIN( value, rows_1 [ , rows_2 ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Description
Returns the moving minimum of values in a fixed-size window defined by the sort order and arguments:

| `rows_1`   | `rows_2`   | Window                                                                |
|:-----------|:-----------|:----------------------------------------------------------------------|
| positive   | -          | The current row and `rows_1` following rows.                          |
| negative   | -          | The current row and -`rows_1` preceding rows.                         |
| any sign   | any sign   | `rows_1` preceding rows, the current row and `rows_2` following rows. |


Window functions with a similar behavior: [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

See also [MIN](MIN.md), [RMIN](RMIN.md).

**Argument types:**
- `value` — `Boolean | Date | Datetime | Number | String | UUID`
- `rows_1` — `Number (whole)`
- `rows_2` — `Number (whole)`


**Return type**: Same type as (`value`)

{% note info %}

Only constant values are accepted for arguments (rows_1, rows_2).

{% endnote %}


#### Examples

```
MMIN([Profit], -2)
```

```
MMIN([Profit], 3)
```

```
MMIN([Profit] 5, 5 TOTAL)
```

```
MMIN([Profit], -5 WITHIN [Date])
```

```
MMIN([Profit], -5 AMONG [Date])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
